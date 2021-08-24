import 'package:app_atractivos/src/models/usuarios_model.dart';
import 'package:app_atractivos/src/preferencias_usuario.dart/preferencias_usuario.dart';
import 'package:app_atractivos/src/providers/usuarios_provider.dart';
import 'package:app_atractivos/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DatosUsuarioPage extends StatelessWidget {
  final _prefs = new PreferenciasUsuario();
  final usuariosProvider = new UsuariosProvider();
  UsuariosModel usuario = new UsuariosModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de usuario'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                // authService.logout();
                _prefs.email = '';
                _prefs.token = '';
                _prefs.ultimaPagina = '';
                Navigator.of(context).pushNamedAndRemoveUntil(
                    'login', (Route<dynamic> route) => false);
                // Navigator.pushReplacementNamed(context, 'login');
              })
        ],
      ),
      drawer: MenuWidget(),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: usuariosProvider.cargarUsuarios(),
          builder:
              (BuildContext context, AsyncSnapshot<UsuariosModel> snapshot) {
            if (snapshot.hasData) {
              usuario = snapshot.data;
              return Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  // key: formKey,
                  child: Column(
                    children: [
                      _crearAvatar(),
                      _crearBoton(context),
                      _datosUsuario(),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _crearAvatar() {
    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(10),
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(180.0)),
              clipBehavior: Clip.antiAlias,
              elevation: 10,
              child: Icon(Icons.person, size: 150)),
        ),
        Text(
          usuario.email,
          style: TextStyle(fontSize: 17),
        )
      ],
    );
  }

  Widget _datosUsuario() {
    return Column(
      children: [
        ListTile(
          title: Text('Nombre', style: TextStyle(fontSize: 19)),
          subtitle: Text(usuario.nombre, style: TextStyle(fontSize: 17)),
          leading: Icon(Icons.check),
        ),
        ListTile(
          title: Text('Apellido', style: TextStyle(fontSize: 19)),
          subtitle: Text(
            usuario.apellido,
            style: TextStyle(fontSize: 17),
          ),
          leading: Icon(Icons.check),
        ),
        ListTile(
          title: Text('Edad', style: TextStyle(fontSize: 19)),
          subtitle: Text(
            usuario.edad,
            style: TextStyle(fontSize: 17),
          ),
          leading: Icon(Icons.check),
        ),
        ListTile(
          title: Text('Ciudad', style: TextStyle(fontSize: 19)),
          subtitle: Text(
            usuario.ciudad,
            style: TextStyle(fontSize: 17),
          ),
          leading: Icon(Icons.check),
        ),
        ListTile(
          title: Text('País', style: TextStyle(fontSize: 19)),
          subtitle: Text(
            usuario.pais,
            style: TextStyle(fontSize: 17),
          ),
          leading: Icon(Icons.check),
        ),
        ListTile(
          title: Text('Sitios turísticos favoritos',
              style: TextStyle(fontSize: 19)),
          subtitle: Text(
            usuario.sitioPreferido,
            style: TextStyle(fontSize: 17),
          ),
          leading: Icon(Icons.check),
        )
      ],
    );
  }

  Widget _crearBoton(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      // padding: EdgeInsets.only(top: 40),
      margin: EdgeInsets.all(20),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, 'ingresoPerfil');
        },
        icon: Icon(Icons.edit),
        label: Text('Editar Perfil', style: TextStyle(fontSize: 19)),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(10),
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xff015249)),
        ),
      ),
    );
  }
}
