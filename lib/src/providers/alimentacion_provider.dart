import 'dart:convert';
import 'package:app_atractivos/src/models/alimentacion_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AlimentacionProvider {
  final String _url = 'https://admin-6c5a5-default-rtdb.firebaseio.com/';
  final storage = new FlutterSecureStorage();

  Future<List<AlimentacionModel>> cargarAlimentacion(query) async {
    final tokenAccess = await storage.read(key: 'token') ?? '';
    final url = Uri.parse('$_url/alimentacion.json?auth=$tokenAccess');
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<AlimentacionModel> alimentacion = [];
    if (decodedData == null) return [];
    decodedData.forEach((id, ali) {
      if (ali.toString().toLowerCase().contains(query.toLowerCase())) {
        final aliTemp = AlimentacionModel.fromJson(ali);
        aliTemp.id = id;
        alimentacion.add(aliTemp);
      }
    });

    return alimentacion;
  }
}
