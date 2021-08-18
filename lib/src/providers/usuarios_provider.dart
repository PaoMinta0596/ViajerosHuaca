import 'dart:convert';
import 'package:app_atractivos/src/models/usuarios_model.dart';
import 'package:app_atractivos/src/preferencias_usuario.dart/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuariosProvider {
  final String _url = 'https://admin-6c5a5-default-rtdb.firebaseio.com/';

  final _prefs = new PreferenciasUsuario();

  Future<UsuariosModel> cargarUsuarios() async {
    final url = Uri.parse('$_url/usuarios.json');
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    UsuariosModel usuario = new UsuariosModel();
    if (decodedData == null) return null;
    decodedData.forEach((id, usu) {
      if (usu.toString().toLowerCase().contains(_prefs.email.toLowerCase())) {
        final usuTemp = UsuariosModel.fromJson(usu);
        usuTemp.id = id;
        usuario = usuTemp;
      }
    });
    return usuario;
  }

  Future<bool> crearUsuario(UsuariosModel usuario) async {
    final url = Uri.parse('$_url/usuarios.json?auth=${_prefs.token}');
    final resp = await http.post(url, body: usuariosModelToJson(usuario));
    final decodedData = json.decode(resp.body);
    // print(decodedData);
    return true;
  }

  Future<bool> editarUsuario(UsuariosModel usuario) async {
    final url =
        Uri.parse('$_url/usuarios/${usuario.id}.json?auth=${_prefs.token}');
    final resp = await http.put(url, body: usuariosModelToJson(usuario));
    final decodedData = json.decode(resp.body);
    // print(decodedData);
    return true;
  }
}
