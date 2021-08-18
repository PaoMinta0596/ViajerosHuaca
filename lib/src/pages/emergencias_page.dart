import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EmergenciasPage extends StatelessWidget {
  List nombre = [
    'Unidad de Policía Comunitaria',
    'Cuerpo de Bomberos del cantón San Pedro de Huaca',
    'Centro de Salud Tipo A - Huaca'
  ];
  List telefono = ['(06) 2973230', '(06) 3012904 - 3012903', '(06) 2973085'];
  List direccion = [
    'Huaca, Calle 8 de Diciembre y Juan León Mera',
    'Huaca, Calle García Moreno y Juan Montalvo',
    'Huaca, Calle 8 de Diciembre y Rubén Fuertes'
  ];
  List imagen = [
    'assets/polica.jpg',
    'assets/bomberos.jpg',
    'assets/subcentro.jpg'
  ];
  List coordenadas = [
    '-77.72769772908798, 0.6271435947929354',
    '-77.724536, 0.633598',
    '-77.724859, 0.640661'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Servicios de emergencia'),
        centerTitle: true,
        elevation: 4,
        actions: [
          IconButton(
              icon: Icon(
                Icons.home,
                size: 35,
              ),
              onPressed: () => Navigator.pushReplacementNamed(context, 'home'))
        ],
      ),

      // drawer: MenuWidget(),
      body: Container(
        child: _listaEmergencias(),
      ),
    );
  }

  Widget _listaEmergencias() {
    return ListView.builder(
      itemCount: nombre.length,
      itemBuilder: (context, i) => _crearItem(context, nombre[i], telefono[i],
          imagen[i], direccion[i], coordenadas[i]),
    );
  }

  Widget _crearItem(BuildContext context, String nombre, String telefono,
      String imagen, String direccion, String coordenadas) {
    return Card(
      elevation: 20.0,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      clipBehavior: Clip.antiAlias,
      //elevation: 0.0,
      child: Column(
        children: [
          FadeInImage(
            image: AssetImage(imagen),
            placeholder: AssetImage('assets/jar-loading.gif'),
            height: 120.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ListTile(
            dense: true,
            title: Text(nombre,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center),
          ),
          ListTile(
            dense: true,
            horizontalTitleGap: 0,
            leading: Icon(Icons.phone, color: Colors.red),
            title: Text(
              telefono,
              style: TextStyle(fontSize: 16.0),
            ),
            trailing: IconButton(
              icon: Icon(Icons.map_outlined, color: Colors.indigo, size: 30.0),
              onPressed: () =>
                  Navigator.pushNamed(context, 'mapa', arguments: coordenadas),
            ),
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.location_on_sharp, color: Colors.lightBlue),
            horizontalTitleGap: 0,
            title: Text(direccion,
                style: TextStyle(
                  fontSize: 16.0,
                )),
          ),
        ],
      ),
    );
  }
}
