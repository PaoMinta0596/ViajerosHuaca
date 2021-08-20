import 'dart:convert';
import 'package:app_atractivos/src/models/transporte_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class TransporteProvider {
  final String _url = 'https://admin-6c5a5-default-rtdb.firebaseio.com/';
  final storage = new FlutterSecureStorage();

  Future<List<TransporteModel>> cargarTransporte(query) async {
    final tokenAccess = await storage.read(key: 'token') ?? '';
    final url = Uri.parse('$_url/transporte.json?auth=$tokenAccess');
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<TransporteModel> transporte = [];
    if (decodedData == null) return [];
    decodedData.forEach((id, trans) {
      if (trans.toString().toLowerCase().contains(query.toLowerCase())) {
        final transTemp = TransporteModel.fromJson(trans);
        transTemp.id = id;
        transporte.add(transTemp);
        //print(sit);
      }
    });

    return transporte;
  }
}
