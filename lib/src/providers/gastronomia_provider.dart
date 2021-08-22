import 'dart:convert';
import 'package:app_atractivos/src/models/gastronomia_model.dart';
import 'package:app_atractivos/src/preferencias_usuario.dart/preferencias_usuario.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class GastronomiaProvider {
  final String _url = 'https://admin-6c5a5-default-rtdb.firebaseio.com/';
  final storage = new FlutterSecureStorage();
  final _prefs = new PreferenciasUsuario();

  Future<List<GastronomiaModel>> cargarGastronomia(query) async {
    final tokenAccess = await storage.read(key: 'token') ?? '';
    print('token de gastronomía');
    print(tokenAccess);
    final url = Uri.parse('$_url/gastronomia.json?auth=$tokenAccess');
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<GastronomiaModel> gastronomia = [];
    if (decodedData == null) return [];
    decodedData.forEach((id, gast) {
      if (gast.toString().toLowerCase().contains(query.toLowerCase())) {
        final gastTemp = GastronomiaModel.fromJson(gast);
        gastTemp.id = id;
        gastronomia.add(gastTemp);
      }
    });

    return gastronomia;
  }
}
