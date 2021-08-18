import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class AbrirEnlace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String url = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: WebviewScaffold(
          url: url,
          hidden: true,
          withJavascript: true,
          enableAppScheme: true,
        ),
      ),
    );
  }
}
