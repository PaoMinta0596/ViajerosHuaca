import 'package:app_atractivos/src/models/sitio_model.dart';
import 'package:app_atractivos/src/utils/expandir_texto.dart';
import 'package:app_atractivos/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

// ignore: must_be_immutable
class DetalleSitioPage extends StatelessWidget {
  SitiosModel sitio = new SitiosModel();
  @override
  Widget build(BuildContext context) {
    final SitiosModel sitData = ModalRoute.of(context).settings.arguments;

    if (sitData != null) {
      sitio = sitData;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('${sitio.nombre}'),
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
            child: Column(
              children: [_crearBody(context)],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearBody(BuildContext context) {
    return Stack(
      children: [_mostrarFoto(), _informacion(), _tarjetaIconos(context)],
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
              text: '${sitio.descripcion}',
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text('Horario', style: TextStyle(fontSize: 16)),
              subtitle:
                  Text('${sitio.horario}', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.timer_rounded, color: Colors.blue),
              horizontalTitleGap: 0,
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text('Ubicación', style: TextStyle(fontSize: 16)),
              subtitle:
                  Text('${sitio.ubicacion}', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.location_on, color: Colors.red),
              horizontalTitleGap: 0,
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text('Actividades', style: TextStyle(fontSize: 16)),
              subtitle:
                  Text('${sitio.actividades}', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.attractions, color: Colors.orange[700]),
              horizontalTitleGap: 0,
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text('Costo', style: TextStyle(fontSize: 16)),
              subtitle: Text('${sitio.costo}', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.attach_money_rounded, color: Colors.green),
              horizontalTitleGap: 0,
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text('Teléfono', style: TextStyle(fontSize: 16)),
              subtitle:
                  Text('${sitio.telefono}', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.phone, color: Colors.blueAccent),
              horizontalTitleGap: 0,
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text('Correo Electrónico', style: TextStyle(fontSize: 16)),
              subtitle: Text(
                  sitio.correo != null ? '${sitio.correo}' : 'No dispone',
                  style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.email_outlined, color: Colors.red[300]),
              horizontalTitleGap: 0,
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text('Medidas de bioseguridad',
                  style: TextStyle(fontSize: 16)),
              subtitle:
                  Text('${sitio.bioseguridad}', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.coronavirus, color: Colors.green[900]),
              horizontalTitleGap: 0,
            ),
            Divider(),
            ListTile(
              dense: true,
              title: Text('Acceso a mascotas', style: TextStyle(fontSize: 16)),
              subtitle: _mascotasAcceso(),
              leading: Icon(Icons.pets, color: Colors.yellow[700]),
              horizontalTitleGap: 0,
            ),
          ],
        ));
  }

  _mascotasAcceso() {
    if (sitio.mascotas == 'Si') {
      return Text('El acceso a mascotas es libre',
          style: TextStyle(fontSize: 15));
    } else {
      return Text('No se permite el acceso a mascotas',
          style: TextStyle(fontSize: 15));
    }
  }

  Widget _mostrarFoto() {
    if (sitio.imagenes != null) {
      return Container(
        margin: EdgeInsets.only(bottom: 50.0),
        child: FadeInImage(
            image: NetworkImage(sitio.imagenes),
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
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 220.0),
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
        padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(Icons.map, color: Colors.indigo, size: 30),
                onPressed: () => Navigator.pushNamed(context, 'mapa',
                    arguments: sitio.coordenadas)),
            IconButton(
                icon: Icon(Icons.panorama_photosphere,
                    color: Colors.orange[800], size: 30),
                onPressed: () => abrirServicio(context, sitio.recorrido)),
            IconButton(
                icon: Image.asset('assets/facebook.png', width: 28),
                onPressed: () => abrirServicio(context, sitio.facebook)),
            IconButton(
                icon: Image.asset('assets/whatsapp.png', height: 28),
                onPressed: () => abrirEnlace(context, sitio.whatsapp)),
            IconButton(
                icon: Icon(Icons.share_outlined, color: Colors.teal, size: 30),
                onPressed: () async {
                  await Share.share(
                      '${sitio.nombre} \n \nEs un lugar hermoso que debes conocer cuando visites el cantón San Pedro de Huaca. \n\n Conoce más acerca del cantón visitando la app VIAJEROS HUACA',
                      subject: 'San Pedro de Huaca.');
                }),
          ],
        ),
      ),
    );
  }
}
