import 'package:app_atractivos/src/models/eventos_model.dart';
import 'package:app_atractivos/src/utils/control_fecha.dart';
import 'package:app_atractivos/src/utils/expandir_texto.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetalleEventosPage extends StatelessWidget {
  EventosModel evento = new EventosModel();
  String texto;
  @override
  Widget build(BuildContext context) {
    final EventosModel eveData = ModalRoute.of(context).settings.arguments;
    if (eveData != null) {
      evento = eveData;
    }
    texto = fechaCaducada(evento.fechaFin);
    return Scaffold(
      appBar: AppBar(
        title: Text('Evento Programado'),
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
                _informacion(context),
                _caducacion(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _informacion(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 280.0),
        padding:
            EdgeInsets.only(top: 5.0, bottom: 20.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            ListTile(
              title: Text('${evento.nombre}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
            ),
            ExpandableText(
              maxLines: 100,
              text: '${evento.descripcion}',
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text('Fecha de Inicio', style: TextStyle(fontSize: 16)),
              subtitle: Text(
                '${evento.fechaInicio}',
                style: TextStyle(fontSize: 15),
              ),
              leading: Icon(Icons.calendar_today, color: Colors.blue),
              horizontalTitleGap: 0,
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text('Fecha de Fin', style: TextStyle(fontSize: 16)),
              subtitle:
                  Text('${evento.fechaFin}', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.calendar_today, color: Colors.blue),
              horizontalTitleGap: 0,
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text('Costo aproximado', style: TextStyle(fontSize: 16)),
              subtitle: Text('${evento.costo}', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.attach_money_rounded, color: Colors.green),
              horizontalTitleGap: 0,
            ),
            Divider(),
            ListTile(
                dense: true,
                title: Text('Ubicación', style: TextStyle(fontSize: 16)),
                subtitle:
                    Text('${evento.ubicacion}', style: TextStyle(fontSize: 15)),
                leading: Icon(Icons.location_on, color: Colors.red),
                horizontalTitleGap: 0,
                trailing: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(165, 165, 175, 0.5),
                    borderRadius: BorderRadius.circular(30.0),
                    //color: Colors.blue[100],
                  ),
                  child: IconButton(
                    iconSize: 30,
                    color: Colors.blue,
                    icon: Icon(Icons.map),
                    onPressed: () => Navigator.pushNamed(context, 'mapa',
                        arguments: evento.coordenadas),
                  ),
                )),
            Divider(),
          ],
        ));
  }

  Widget _mostrarFoto() {
    if (evento.imagenes != null) {
      return Container(
        margin: EdgeInsets.only(bottom: 50.0),
        child: FadeInImage(
            image: NetworkImage(evento.imagenes),
            placeholder: AssetImage('assets/jar-loading.gif'),
            height: 250.0,
            width: double.infinity,
            fit: BoxFit.cover),
      );
    } else {
      return Container(
        child: Image(
          image: AssetImage('assets/no-image.png'),
          height: 150.0,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  Widget _caducacion(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 40, vertical: 220),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        elevation: 10.0,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(165, 165, 175, 0.5),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: ListTile(
            title: Text(
              texto,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
