import 'package:app_atractivos/src/models/usuarios_model.dart';
import 'package:app_atractivos/src/providers/usuario_provider.dart';
import 'package:app_atractivos/src/providers/usuarios_provider.dart';
import 'package:app_atractivos/src/utils/utils.dart';
import 'package:app_atractivos/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  UsuariosModel usuario = new UsuariosModel();
  final usuariosProvider = new UsuariosProvider();
  final usuarioProvider = new UsuarioProvider();
  // bool _guardando = false;
  String password;
  String valueChoose;
  List preferencias = ['Naturales', 'Culturales'];
  bool cubrir = true;
  IconData icono = Icons.lock_outline;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: MenuWidget(),
      body: Stack(children: [
        _crearFondo(context),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Container(height: 10.0),
                ),
                _crearFormulario(),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'login'),
                  child: Text(
                    '¿Ya tienes una cuenta? Login',
                    style: TextStyle(fontSize: 17),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _crearFormulario() {
    final size = MediaQuery.of(context).size;
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: size.width * 0.85,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // _crearAvatar(),
              Text(
                'Crear cuenta de usuario',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              _nombreUsuario(),
              _apellidoUsuario(),
              _edadUsuario(),
              _paisUsuario(),
              _ciudadUsuario(),
              _emailUsuario(),
              _passwordUsuario(),
              _preferencia(),
              _crearBoton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoSuperior = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[Color(0xff015249), Color(0xff57BC90)])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.2)),
    );

    return Stack(
      children: <Widget>[
        fondoSuperior,
        Positioned(top: -30.0, left: 60.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(top: 150.0, right: 0.0, child: circulo),
        Positioned(top: 190.0, left: 80.0, child: circulo),
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
          return 'El campo está vacío, por favor ingrese su nombre';
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
          return 'El campo está vacío, por favor ingrese su apellido';
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
          return 'El campo debe ser llenado solo con números';
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
      decoration: InputDecoration(labelText: 'País'),
      onSaved: (value) => usuario.pais = value,
      validator: (value) {
        if (value.isEmpty) {
          return 'El campo está vacío, por favor ingrese su país';
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
          return 'El campo está vacío, por favor ingrese su ciudad';
        } else {
          return null;
        }
      },
    );
  }

  Widget _emailUsuario() {
    return TextFormField(
        initialValue: usuario.ciudad,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(labelText: 'Correo electrónico'),
        onSaved: (value) => usuario.email = value,
        validator: (value) {
          Pattern pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regExp = new RegExp(pattern);
          if (regExp.hasMatch(value)) {
            return null;
          } else {
            return ('No es un correo válido');
          }
        });
  }

  Widget _passwordUsuario() {
    return TextFormField(
      initialValue: password,
      obscureText: cubrir,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        suffixIcon: GestureDetector(
            child: Icon(icono),
            onTap: () {
              setState(() {
                cubrir = !cubrir;
                if (icono == Icons.lock_outline) {
                  icono = Icons.lock_open;
                } else {
                  icono = Icons.lock_outline;
                }
              });
            }),
      ),
      onSaved: (value) => password = value,
      validator: (value) {
        if (value.length < 6) {
          return 'La contraseña es demasiado corta';
        } else {
          return null;
        }
      },
    );
  }

  Widget _preferencia() {
    return DropdownButtonFormField(
      hint: Text('Seleccione su categoría preferida'),
      iconSize: 36,
      isExpanded: true,
      value: valueChoose,
      onChanged: (newValue) {
        setState(() {
          valueChoose = newValue;
        });
      },
      items: preferencias.map((valueItem) {
        return DropdownMenuItem(value: valueItem, child: Text(valueItem));
      }).toList(),
      onSaved: (value) => usuario.sitioPreferido = value,
      validator: (value) {
        if (value.isEmpty) {
          return 'Seleccione una categoría';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearBoton() {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 40),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(10),
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xff57BC90)),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Crear cuenta'),
        ),
        onPressed: _submit,
      ),
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    print(usuario.email);
    final info = await usuarioProvider.nuevoUsuario(usuario.email, password);
    // setState(() {
    //   _guardando = true;
    // });

    if (info['ok']) {
      usuariosProvider.crearUsuario(usuario);
      // setState(() {
      //   _guardando = false;
      // });
      // mostrarSnackBar('Datos guardados');
      Navigator.pushReplacementNamed(context, 'login');
    } else {
      mostrarAlerta(
          context, 'El correo eléctrónico ya se encuentra registrado');
    }
  }
}
