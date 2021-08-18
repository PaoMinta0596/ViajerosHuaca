import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_atractivos/src/models/sitio_model.dart';

class SitiosProvider {
  final String _url = 'https://admin-6c5a5-default-rtdb.firebaseio.com/';

  // Future<List<SitiosModel>> cargarSitios() async {
  //   final url = Uri.parse('$_url/sitios.json');
  //   final resp = await http.get(url);

  //   final Map<String, dynamic> decodedData = json.decode(resp.body);

  //   final List<SitiosModel> sitios = [];
  //   if (decodedData == null) return [];
  //   decodedData.forEach((id, sit) {
  //     final sitTemp = SitiosModel.fromJson(sit);
  //     sitTemp.id = id;
  //     sitios.add(sitTemp);
  //   });

  //   return sitios;
  // }

  Future<List<SitiosModel>> buscarSitios(String query) async {
    final url = Uri.parse('$_url/sitios.json');
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<SitiosModel> sitios = [];

    if (decodedData == null) return [];

    decodedData.forEach((id, sit) {
      if (sit.toString().toLowerCase().contains(query.toLowerCase())) {
        final sitTemp = SitiosModel.fromJson(sit);
        sitTemp.id = id;
        sitios.add(sitTemp);
      }
    });

    return sitios;
  }
}
