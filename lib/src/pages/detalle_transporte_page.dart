import 'package:app_atractivos/src/models/transporte_model.dart';
import 'package:app_atractivos/src/utils/expandir_texto.dart';
import 'package:app_atractivos/src/utils/utils.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetalleTransportePage extends StatelessWidget {
  TransporteModel transporte = new TransporteModel();
  @override
  Widget build(BuildContext context) {
    final TransporteModel transData = ModalRoute.of(context).settings.arguments;

    if (transData != null) {
      transporte = transData;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('${transporte.nombre}'),
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
                _tarjetaIconos(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _informacion() {
    return Container(
        margin: EdgeInsets.only(top: 300.0),
        padding:
            EdgeInsets.only(top: 5.0, bottom: 20.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            ExpandableText(
              maxLines: 100,
              text: '${transporte.descripcion}',
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text('Horario', style: TextStyle(fontSize: 16)),
              subtitle:
                  Text('${transporte.horario}', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.timer_rounded, color: Colors.blue),
              horizontalTitleGap: 0,
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text('Ubicación', style: TextStyle(fontSize: 16)),
              subtitle: Text('${transporte.ubicacion}',
                  style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.location_on, color: Colors.red),
              horizontalTitleGap: 0,
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text('Ruta', style: TextStyle(fontSize: 16)),
              subtitle:
                  Text('${transporte.rutas}', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.timeline_sharp, color: Colors.green),
              horizontalTitleGap: 0,
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text('Teléfono', style: TextStyle(fontSize: 16)),
              subtitle: Text('${transporte.telefono}',
                  style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.phone, color: Colors.blueAccent),
              horizontalTitleGap: 0,
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text('Correo electrónico', style: TextStyle(fontSize: 16)),
              subtitle:
                  Text('${transporte.correo}', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.mail_outline, color: Colors.redAccent),
              horizontalTitleGap: 0,
            ),
            Divider()
          ],
        ));
  }

  Widget _mostrarFoto() {
    if (transporte.imagenes != null) {
      return Container(
        margin: EdgeInsets.only(bottom: 50.0),
        child: FadeInImage(
            image: NetworkImage(transporte.imagenes),
            placeholder: AssetImage('assets/jar-loading.gif'),
            height: 250.0,
            width: double.infinity,
            fit: BoxFit.cover),
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

  Widget _tarjetaIconos(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 120.0,
        vertical: 220.0,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 10.0,
      child: Container(
        //color: Color(0xff77C9D4),
        decoration: BoxDecoration(
          color: Color.fromRGBO(165, 165, 175, 0.5),
          borderRadius: BorderRadius.circular(30.0),
          //color: Colors.blue[100],
        ),
        height: 55.0,
        padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(Icons.map, color: Colors.indigo, size: 30),
                onPressed: () => Navigator.pushNamed(context, 'mapa',
                    arguments: transporte.coordenadas)),
            IconButton(
                icon: Image.asset('assets/facebook.png', width: 28),
                onPressed: () => abrirServicio(context, transporte.facebook)),
          ],
        ),
      ),
    );
  }
}
