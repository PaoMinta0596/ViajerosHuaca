import 'package:app_atractivos/src/bloc/auth_service.dart';
import 'package:app_atractivos/src/preferencias_usuario.dart/preferencias_usuario.dart';
import 'package:app_atractivos/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:app_atractivos/src/providers/login_form_provider.dart';
import 'package:provider/provider.dart';

import 'package:app_atractivos/src/ui/input_decorations.dart';
import 'package:app_atractivos/src/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    // prefs.ultimaPagina = 'login';
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 220),
          CardContainer(
              child: Column(
            children: [
              SizedBox(height: 10),
              Text('Ingresar', style: Theme.of(context).textTheme.headline4),
              SizedBox(height: 30),
              ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(), child: _LoginForm())
            ],
          )),
          SizedBox(height: 40),
          TextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, 'register'),
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      Color(0xff57BC90).withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder())),
              child: Text(
                'Crear una nueva cuenta',
                style: TextStyle(
                  fontSize: 17,
                  // fontWeight: FontWeight.bold,
                ),
              )),
          SizedBox(height: 50),
        ],
      ),
    )));
  }
}

class _LoginForm extends StatefulWidget {
  @override
  __LoginFormState createState() => __LoginFormState();
}

class __LoginFormState extends State<_LoginForm> {
  bool cubrir = true;

  IconData icono = Icons.lock_outline;

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Ingrese su correo electrónico',
                  labelText: 'Correo electrónico',
                  prefixIcon: Icons.alternate_email_rounded),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';
              },
            ),
            SizedBox(height: 30),
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
                    : 'La contraseña debe de ser de 6 caracteres';
              },
            ),
            SizedBox(height: 50),
            ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    elevation: MaterialStateProperty.all(10),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff57BC90)),
                    overlayColor: MaterialStateProperty.all(Colors.grey)),

                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10)),
                // disabledColor: Colors.grey,
                // elevation: 0,
                // color: Color(0xff57BC90),
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

                        // TODO_validar si el login es correcto

                        final String errorMessage = await authService.login(
                            loginForm.email, loginForm.password);

                        if (errorMessage == null) {
                          Navigator.pushReplacementNamed(context, 'home');
                        } else {
                          // print('error de base');
                          // print(errorMessage);
                          mostrarAlerta(context,
                              'El usuario o contraseña ingresados son incorrectos');
                          loginForm.isLoading = false;
                        }
                      }),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
