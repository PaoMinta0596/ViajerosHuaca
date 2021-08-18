import 'package:app_atractivos/src/models/gastronomia_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetalleGastronomiaPage extends StatelessWidget {
  GastronomiaModel gastronomia = new GastronomiaModel();
  @override
  Widget build(BuildContext context) {
    final GastronomiaModel gastData = ModalRoute.of(context).settings.arguments;

    if (gastData != null) {
      gastronomia = gastData;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('${gastronomia.nombre}'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.home,
                size: 35,
              ),
              onPressed: () => Navigator.pushReplacementNamed(context, 'home'))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          //padding: EdgeInsets.all(15.0),
          child: Form(
            child: Stack(
              children: [
                _mostrarFoto(),
                _informacion(),
                // _tarjetaIconos(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _informacion() {
    return Container(
        margin: EdgeInsets.only(top: 250.0),
        padding:
            EdgeInsets.only(top: 5.0, bottom: 20.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            ListTile(
              title: Text('${gastronomia.nombre}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text('Costo aproximado', style: TextStyle(fontSize: 16)),
              subtitle:
                  Text('${gastronomia.costo}', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.attach_money_rounded, color: Colors.green),
              horizontalTitleGap: 0,
            ),
            Divider(),
            SizedBox(height: 15),
            Text(
              '${gastronomia.descripcion}',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ));
  }

  Widget _mostrarFoto() {
    if (gastronomia.imagenes != null) {
      return Container(
        margin: EdgeInsets.only(bottom: 50.0),
        child: FadeInImage(
            image: NetworkImage(gastronomia.imagenes),
            placeholder: AssetImage('assets/jar-loading.gif'),
            height: 250.0,
            width: double.infinity,
            fit: BoxFit.fill),
      );
    } else {
      return Container(
        child: Image(
          image: AssetImage('assets/no-image.png'),
          height: 250.0,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }
  }
}
