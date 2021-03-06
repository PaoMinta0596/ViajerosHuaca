import 'package:app_atractivos/src/models/usuarios_model.dart';
// import 'package:app_atractivos/src/preferencias_usuario.dart/preferencias_usuario.dart';
import 'package:app_atractivos/src/providers/usuarios_provider.dart';
import 'package:app_atractivos/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UsuarioPage extends StatefulWidget {
  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  // final _prefs = new PreferenciasUsuario();

  UsuariosModel usuario = new UsuariosModel();
  final usuariosProvider = new UsuariosProvider();
  bool _guardando = false;
  // List<UsuariosModel> usuarios;

  @override
  Widget build(BuildContext context) {
    // final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Perfil de usuario'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.home,
                size: 35,
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    'home', (Route<dynamic> route) => false);
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
                  key: formKey,
                  child: Column(
                    children: [
                      _crearAvatar(),
                      SizedBox(height: 20),
                      _nombreUsuario(),
                      SizedBox(height: 20),
                      _apellidoUsuario(),
                      SizedBox(height: 20),
                      _edadUsuario(),
                      SizedBox(height: 20),
                      _paisUsuario(),
                      SizedBox(height: 20),
                      _ciudadUsuario(),
                      ListTile(
                        dense: true,
                        subtitle: Text('Sitios tur??sticos preferidos',
                            style: TextStyle(fontSize: 14)),
                      ),
                      _preferencia(),
                      _crearBoton()
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

  Widget _nombreUsuario() {
    return TextFormField(
      initialValue: usuario.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre'),
      onSaved: (value) => usuario.nombre = value,
      validator: (value) {
        if (value.isEmpty) {
          return 'El campo est?? vac??o, por ingrese su nombre';
        } else {
          return null;
        }
      },
    );
  }

  Widget _apellidoUsuario() {
    return TextFormField(
      initialValue: usuario.apellido,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Apellido'),
      onSaved: (value) => usuario.apellido = value,
      validator: (value) {
        if (value.isEmpty) {
          return 'El campo est?? vac??o, por favor ingrese su apellido';
        } else {
          return null;
        }
      },
    );
  }

  Widget _edadUsuario() {
    return TextFormField(
      initialValue: usuario.edad,
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Edad'),
      onSaved: (value) => usuario.edad = value,
      validator: (value) {
        final n = num.tryParse(value);
        if (value.isEmpty || n == null) {
          return 'El campo debe ser llenado solo con n??meros';
        } else {
          return null;
        }
      },
    );
  }

  Widget _paisUsuario() {
    return TextFormField(
      initialValue: usuario.pais,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Pais'),
      onSaved: (value) => usuario.pais = value,
      validator: (value) {
        if (value.isEmpty) {
          return 'El campo est?? vac??o, por favor ingrese su pa??s';
        } else {
          return null;
        }
      },
    );
  }

  Widget _ciudadUsuario() {
    return TextFormField(
      initialValue: usuario.ciudad,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Ciudad'),
      onSaved: (value) => usuario.ciudad = value,
      validator: (value) {
        if (value.isEmpty) {
          return 'El campo est?? vac??o, por favor ingrese su ciudad';
        } else {
          return null;
        }
      },
    );
  }

  Widget _preferencia() {
    return DropdownButtonFormField(
      hint: Text('Categor??a favorita'),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff57BC90)),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff57BC90), width: 2)),
        // prefixIcon: Icon(Icons.border_color, color: Color(0xff57BC90)),
      ),
      value: usuario.sitioPreferido,
      isDense: true,
      onChanged: (String newValue) {
        usuario.sitioPreferido = newValue;
      },
      items: ['Naturales', 'Culturales'].map((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: (value) {
        if (value == null) {
          return 'Seleccione una categor??a de sitio tur??stico';
        } else {
          usuario.sitioPreferido = value;
          return null;
        }
      },
    );
  }

  Widget _crearBoton() {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 40),
      child: ElevatedButton.icon(
        onPressed: (_guardando) ? null : _submit,
        icon: Icon(Icons.save),
        label: Text('Actualizar datos', style: TextStyle(fontSize: 19)),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(10),
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xff015249)),
        ),
      ),
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    setState(() {
      _guardando = true;
    });
    usuariosProvider.editarUsuario(usuario);
    setState(() {
      _guardando = false;
    });
    mostrarSnackBar('Datos actualizados');
    Navigator.pushReplacementNamed(context, 'datosPerfil');
  }

  void mostrarSnackBar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
