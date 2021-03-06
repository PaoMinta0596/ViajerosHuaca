import 'dart:convert';

import 'package:app_atractivos/src/models/eventos_model.dart';
// import 'package:app_atractivos/src/preferencias_usuario.dart/preferencias_usuario.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class EventosProvider {
  final String _url = 'https://admin-6c5a5-default-rtdb.firebaseio.com/';
//  final storage = new FlutterSecureStorage();
  // final _prefs = new PreferenciasUsuario();

  Future<List<EventosModel>> cargarEventos(query) async {
    //  final tokenAccess = await storage.read(key: 'token') ?? '';
    final url = Uri.parse('$_url/eventos.json');
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<EventosModel> eventos = [];
    if (decodedData == null) return [];
    decodedData.forEach((id, eve) {
      if (eve.toString().toLowerCase().contains(query.toLowerCase())) {
        final eveTemp = EventosModel.fromJson(eve);
        eveTemp.id = id;
        eventos.add(eveTemp);
      }
    });

    return eventos;
  }
}
