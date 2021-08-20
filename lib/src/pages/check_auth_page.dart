import 'package:app_atractivos/src/bloc/auth_service.dart';
import 'package:app_atractivos/src/pages/home_page.dart';
import 'package:app_atractivos/src/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckAuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
          child: FutureBuilder(
              future: authService.readToken(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) return Text('');

                if (snapshot.data == null) {
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
                return Container();
              })),
    );
  }
}
