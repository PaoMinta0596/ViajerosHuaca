import 'dart:convert';
import 'package:app_atractivos/src/models/hospedaje_model.dart';
import 'package:http/http.dart' as http;

class HospedajeProvider {
  final String _url = 'https://admin-6c5a5-default-rtdb.firebaseio.com/';

  Future<List<HospedajeModel>> cargarHospedaje(query) async {
    final url = Uri.parse('$_url/hospedaje.json');
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<HospedajeModel> hospedaje = [];
    if (decodedData == null) return [];

    decodedData.forEach((id, hosp) {
      if (hosp.toString().toLowerCase().contains(query.toLowerCase())) {
        final hosTemp = HospedajeModel.fromJson(hosp);
        hosTemp.id = id;
        hospedaje.add(hosTemp);
      }
      //print(sit);
    });

    return hospedaje;
  }
}
