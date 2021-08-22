import 'package:app_atractivos/src/pages/home_page.dart';
import 'package:app_atractivos/src/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CheckAuthPage extends StatelessWidget {
  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _crearMapa(context));
  }

  Widget _crearMapa(BuildContext context) {
    return FutureBuilder(
      future: crearMarcadores(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print('future');
        return Container();
      },
    );
  }

  Future crearMarcadores(BuildContext context) async {
    final token = await storage.read(key: 'token') ?? '';
    print('token de función');
    // print(token);
    if (token == '') {
      Future.microtask(() {
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => LoginPage(),
                transitionDuration: Duration(seconds: 0)));
        // Navigator.of(context).pushReplacementNamed('home');
      });
    } else {
      Future.microtask(() {
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => HomePage(),
                transitionDuration: Duration(seconds: 0)));
        // Navigator.of(context).pushReplacementNamed('home');
      });
    }
    // return token;
  }
}
