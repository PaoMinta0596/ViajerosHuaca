import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

abrirEnlace(BuildContext context, String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    // throw 'Could not launch $url';
    _mostrarAlert(context);
  }
}

//  => await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
abrirServicio(BuildContext context, String url) async {
  if (await canLaunch(url)) {
    await Navigator.pushNamed(context, 'abrirEnlace', arguments: url);
  } else {
    _mostrarAlert(context);
  }
}

void _mostrarAlert(BuildContext context) {
  showDialog(
    context: context,
    // barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Text('Información', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.info, size: 80),
            SizedBox(height: 20),
            Text('Este servicio no está disponible'),
          ],
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Ok',
                style: TextStyle(fontSize: 20),
              )),
        ],
      );
    },
  );
}

void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Información Incorrecta'),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Ok', style: TextStyle(fontSize: 20)),
            )
          ],
        );
      });
}
