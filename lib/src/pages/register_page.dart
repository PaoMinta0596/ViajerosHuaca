import 'package:app_atractivos/src/bloc/auth_service.dart';
import 'package:app_atractivos/src/models/usuarios_model.dart';
import 'package:app_atractivos/src/providers/register_form_provider.dart';
import 'package:app_atractivos/src/providers/usuarios_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_atractivos/src/ui/input_decorations.dart';
import 'package:app_atractivos/src/widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 205),
          CardContainer(
              child: Column(
            children: [
              SizedBox(height: 10),
              Text('Crear cuenta',
                  style: Theme.of(context).textTheme.headline4),
              SizedBox(height: 30),
              ChangeNotifierProvider(
                  create: (_) => RegisterFormProvider(), child: _RegisterForm())
            ],
          )),
          SizedBox(height: 40),
          TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      Color(0xff57BC90).withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder())),
              child: Text(
                '¿Ya tienes una cuenta?',
                style: TextStyle(
                  fontSize: 17,
                ),
              )),
          SizedBox(height: 50),
        ],
      ),
    )));
  }
}

class _RegisterForm extends StatefulWidget {
  @override
  __RegisterFormState createState() => __RegisterFormState();
}

class __RegisterFormState extends State<_RegisterForm> {
  bool cubrir = true;

  IconData icono = Icons.lock_outline;

  UsuariosModel usuario = new UsuariosModel();

  final usuariosProvider = new UsuariosProvider();

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<RegisterFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: true,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Ingrese su nombre',
                  labelText: 'Nombre',
                  prefixIcon: Icons.check_circle),
              onChanged: (value) => loginForm.nombre = value,
              validator: (value) {
                if (value.isEmpty) {
                  return 'El campo está vacío, por favor ingrese su nombre';
                } else {
                  usuario.nombre = value;
                  return null;
                }
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              autocorrect: true,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Ingrese su apellido',
                  labelText: 'Apellido',
                  prefixIcon: Icons.check_circle),
              onChanged: (value) => loginForm.apellido = value,
              validator: (value) {
                if (value.isEmpty) {
                  return 'El campo está vacío, por favor ingrese su apellido';
                } else {
                  usuario.apellido = value;
                  return null;
                }
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              autocorrect: true,
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Ingrese su edad',
                  labelText: 'Edad',
                  prefixIcon: Icons.check_circle),
              onChanged: (value) => loginForm.edad = value,
              validator: (value) {
                final n = num.tryParse(value);
                if (value.isEmpty || n == null) {
                  return 'El campo debe ser llenado solo con números';
                } else {
                  usuario.edad = value;
                  return null;
                }
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              autocorrect: true,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Ingrese su país',
                  labelText: 'País',
                  prefixIcon: Icons.check_circle),
              onChanged: (value) => loginForm.pais = value,
              validator: (value) {
                if (value.isEmpty) {
                  return 'El campo está vacío, por favor ingrese su país';
                } else {
                  usuario.pais = value;
                  return null;
                }
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              autocorrect: true,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Ingrese su ciudad',
                  labelText: 'Ciudad',
                  prefixIcon: Icons.check_circle),
              onChanged: (value) => loginForm.ciudad = value,
              validator: (value) {
                if (value.isEmpty) {
                  return 'El campo está vacío, por favor ingrese su ciudad';
                } else {
                  usuario.ciudad = value;
                  return null;
                }
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField(
              hint: Text('Sitios turísticos preferidos'),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff57BC90)),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff57BC90), width: 2)),
                prefixIcon: Icon(Icons.check_circle, color: Color(0xff57BC90)),
              ),
              value: null,
              isDense: true,
              onChanged: (String newValue) {
                loginForm.sitioPreferido = newValue;
              },
              items: ['Naturales', 'Culturales'].map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return 'Seleccione una categoría de sitio turístico';
                } else {
                  usuario.sitioPreferido = value;
                  return null;
                }
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'john.doe@gmail.com',
                  labelText: 'Correo electrónico',
                  prefixIcon: Icons.alternate_email_rounded),
              onChanged: (value) {
                loginForm.email = value;
                usuario.email = value;
              },
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              obscureText: cubrir,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff57BC90)),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff57BC90), width: 2)),
                hintText: '******',
                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.lock_outline, color: Color(0xff57BC90)),
                labelStyle: TextStyle(color: Colors.grey),
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
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe contener mínimo 6 caracteres';
              },
            ),
            SizedBox(height: 40),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Color(0xff57BC90),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: Text(
                      loginForm.isLoading ? 'Espere' : 'Ingresar',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        final authService =
                            Provider.of<AuthService>(context, listen: false);

                        if (!loginForm.isValidForm()) return;

                        loginForm.isLoading = true;

                        // TODO: validar si el login es correcto

                        final String errorMessage = await authService
                            .createUser(loginForm.email, loginForm.password);

                        if (errorMessage == null) {
                          usuariosProvider.crearUsuario(usuario);
                          print(usuario.rol);
                          Navigator.pushReplacementNamed(context, 'home');
                        } else {
                          print(errorMessage);
                          loginForm.isLoading = false;
                        }
                      }),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
