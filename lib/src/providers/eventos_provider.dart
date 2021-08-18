import 'dart:convert';

import 'package:app_atractivos/src/models/eventos_model.dart';
import 'package:http/http.dart' as http;

class EventosProvider {
  final String _url = 'https://admin-6c5a5-default-rtdb.firebaseio.com/';

  Future<List<EventosModel>> cargarEventos(query) async {
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
