import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MapaPage extends StatelessWidget {
  final map = new MapController();
  @override
  Widget build(BuildContext context) {
    final String coordenadas = ModalRoute.of(context).settings.arguments;

    final lalo = coordenadas.substring(0).split(',');
    final lat = double.parse(lalo[1]);
    final lng = double.parse(lalo[0]);

    return Scaffold(
        appBar: AppBar(
          title: Text('Coordenadas Geográficas'),
          actions: [
            IconButton(
                icon: Icon(Icons.my_location),
                onPressed: () {
                  map.move(LatLng(lat, lng), 16);
                })
          ],
        ),
        body: FlutterMap(
          mapController: map,
          options: MapOptions(
            center: LatLng(lat, lng),
            zoom: 16.0,
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
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(lat, lng),
                  builder: (ctx) => Container(
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 45,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
