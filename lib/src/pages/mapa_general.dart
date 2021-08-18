import 'package:app_atractivos/src/models/alimentacion_model.dart';
import 'package:app_atractivos/src/models/eventos_model.dart';
import 'package:app_atractivos/src/models/hospedaje_model.dart';
import 'package:app_atractivos/src/models/sitio_model.dart';
import 'package:app_atractivos/src/models/transporte_model.dart';
import 'package:app_atractivos/src/providers/alimentacion_provider.dart';
import 'package:app_atractivos/src/providers/eventos_provider.dart';
import 'package:app_atractivos/src/providers/hospedaje_provider.dart';
import 'package:app_atractivos/src/providers/transporte_provider.dart';
import 'package:app_atractivos/src/widgets/menu_widget.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:app_atractivos/src/providers/sitios_provider.dart';

class MapaGeneralPage extends StatefulWidget {
  @override
  _MapaGeneralPageState createState() => _MapaGeneralPageState();
}

class _MapaGeneralPageState extends State<MapaGeneralPage> {
  final map = new MapController();
  List<SitiosModel> sitios;
  List<AlimentacionModel> alimentacion;
  List<TransporteModel> transporte;
  List<HospedajeModel> hospedaje;
  List<EventosModel> eventos;

  final sitiosProvider = new SitiosProvider();
  final alimentacionProvider = new AlimentacionProvider();
  final transporteProvider = new TransporteProvider();
  final hospedajeProvider = new HospedajeProvider();
  final eventosProvider = new EventosProvider();

  List<Marker> todosMarcadores = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: Text('Mapa del cantón'),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.my_location),
                onPressed: () {
                  map.move(LatLng(0.6322040310107251, -77.72553406089888), 17);
                })
          ],
        ),
        drawer: MenuWidget(),
        body: _crearMapa());
  }

  Widget _crearMapa() {
    return FutureBuilder(
        future: crearMarcadores(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return FlutterMap(
              mapController: map,
              options: MapOptions(
                center: LatLng(0.6322040310107251, -77.72553406089888),
                zoom: 17.0,
              ),
              layers: [
                TileLayerOptions(
                    urlTemplate:
                        "https://api.mapbox.com/styles/v1/paominta20/ckpj3cisf2ij217qqoa0ipzu4/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicGFvbWludGEyMCIsImEiOiJja3BoZzllczMwZmwzMm9wZWphYWRxNzEyIn0.a91z3N5f-oaRPTnn9qnCoQ",
                    additionalOptions: {
                      'accessToken':
                          'pk.eyJ1IjoicGFvbWludGEyMCIsImEiOiJja3BoZzllczMwZmwzMm9wZWphYWRxNzEyIn0.a91z3N5f-oaRPTnn9qnCoQ',
                      'id': 'mapbox.mapbox-streets-v8'
                    }),
                MarkerLayerOptions(
                  markers: todosMarcadores,
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Future crearMarcadores() async {
    sitios = await sitiosProvider.buscarSitios('');
    alimentacion = await alimentacionProvider.cargarAlimentacion('');
    transporte = await transporteProvider.cargarTransporte('');
    hospedaje = await hospedajeProvider.cargarHospedaje('');
    eventos = await eventosProvider.cargarEventos('');

    for (var i = 0; i < sitios.length; i++) {
      var imagen;

      if (sitios[i].categoria == 'Naturales') {
        imagen = 'assets/pinNaturales.png';
      } else {
        if (sitios[i].categoria == 'Culturales') {
          imagen = 'assets/pinCulturales.png';
        } else {
          if (sitios[i].categoria == 'Religiosos') {
            imagen = 'assets/pinReligiosos.png';
          }
        }
      }

      final lalo = sitios[i].coordenadas.substring(0).split(',');
      final lat = double.parse(lalo[1]);
      final lng = double.parse(lalo[0]);
      todosMarcadores.add(_marcadoresSitios(lat, lng, sitios[i], imagen));
    }

    for (var i = 0; i < alimentacion.length; i++) {
      final lalo = alimentacion[i].coordenadas.substring(0).split(',');
      final lat = double.parse(lalo[1]);
      final lng = double.parse(lalo[0]);
      todosMarcadores.add(_marcadoresAlimentacion(lat, lng, alimentacion[i]));
    }

    for (var i = 0; i < transporte.length; i++) {
      final lalo = transporte[i].coordenadas.substring(0).split(',');
      final lat = double.parse(lalo[1]);
      final lng = double.parse(lalo[0]);
      todosMarcadores.add(_marcadoresTransporte(lat, lng, transporte[i]));
    }

    for (var i = 0; i < hospedaje.length; i++) {
      final lalo = hospedaje[i].coordenadas.substring(0).split(',');
      final lat = double.parse(lalo[1]);
      final lng = double.parse(lalo[0]);
      todosMarcadores.add(_marcadoresHospedaje(lat, lng, hospedaje[i]));
    }

    for (var i = 0; i < eventos.length; i++) {
      final lalo = eventos[i].coordenadas.substring(0).split(',');
      final lat = double.parse(lalo[1]);
      final lng = double.parse(lalo[0]);
      todosMarcadores.add(_marcadoresEventos(lat, lng, eventos[i]));
    }

    return todosMarcadores;
  }

  Marker _marcadoresSitios(
      double lat, double lng, SitiosModel sitio, String imagen) {
    return Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(lat, lng),
      builder: (ctx) => GestureDetector(
        onTap: () {
          // Mostrar uma SnackBar quando clicar em um marcador
          ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
              backgroundColor: Colors.black54,
              content: ListTile(
                  onTap: () => Navigator.pushNamed(context, 'detalleSitio',
                      arguments: sitio),
                  title: Text(
                    sitio.nombre,
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Image.network(sitio.imagenes),
                  subtitle: Text(sitio.horario,
                      style: TextStyle(color: Colors.white)))));
        },
        child: Container(
          child: Image(image: AssetImage(imagen)),
        ),
      ),
    );
  }

  Marker _marcadoresAlimentacion(
      double lat, double lng, AlimentacionModel alimentacion) {
    return Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(lat, lng),
      builder: (ctx) => GestureDetector(
        onTap: () {
          // Mostrar uma SnackBar quando clicar em um marcador
          ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
              backgroundColor: Colors.black54,
              content: ListTile(
                  onTap: () => Navigator.pushNamed(
                      context, 'detalleAlimentacion', arguments: alimentacion),
                  title: Text(
                    alimentacion.nombre,
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Image.network(alimentacion.imagenes),
                  subtitle: Text(alimentacion.horario,
                      style: TextStyle(color: Colors.white)))));
        },
        child: Container(
          child: Image(image: AssetImage('assets/restaurante.png')),
        ),
      ),
    );
  }

  Marker _marcadoresTransporte(
      double lat, double lng, TransporteModel transporte) {
    return Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(lat, lng),
      builder: (ctx) => GestureDetector(
        onTap: () {
          // Mostrar uma SnackBar quando clicar em um marcador
          ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
              backgroundColor: Colors.black54,
              content: ListTile(
                  onTap: () => Navigator.pushNamed(context, 'detalleTransporte',
                      arguments: transporte),
                  title: Text(
                    transporte.nombre,
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Image.network(transporte.imagenes),
                  subtitle: Text(transporte.horario,
                      style: TextStyle(color: Colors.white)))));
        },
        child: Container(
          child: Image(image: AssetImage('assets/transporte.png')),
        ),
      ),
    );
  }

  Marker _marcadoresHospedaje(
      double lat, double lng, HospedajeModel hospedaje) {
    return Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(lat, lng),
      builder: (ctx) => GestureDetector(
        onTap: () {
          // Mostrar uma SnackBar quando clicar em um marcador
          ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
              backgroundColor: Colors.black54,
              content: ListTile(
                  onTap: () => Navigator.pushNamed(context, 'detalleHospedaje',
                      arguments: hospedaje),
                  title: Text(
                    hospedaje.nombre,
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Image.network(hospedaje.imagenes),
                  subtitle: Text(hospedaje.horario,
                      style: TextStyle(color: Colors.white)))));
        },
        child: Container(
          child: Image(image: AssetImage('assets/hospedaje.png')),
        ),
      ),
    );
  }

  Marker _marcadoresEventos(double lat, double lng, EventosModel eventos) {
    return Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(lat, lng),
      builder: (ctx) => GestureDetector(
        onTap: () {
          // Mostrar uma SnackBar quando clicar em um marcador
          ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
              backgroundColor: Colors.black54,
              content: ListTile(
                  onTap: () => Navigator.pushNamed(context, 'detalleEventos',
                      arguments: eventos),
                  title: Text(
                    eventos.nombre,
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Image.network(eventos.imagenes),
                  subtitle: Text(eventos.fechaInicio,
                      style: TextStyle(color: Colors.white)))));
        },
        child: Container(
          child: Image(image: AssetImage('assets/eventos.png')),
        ),
      ),
    );
  }
}
