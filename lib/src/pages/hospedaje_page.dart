import 'package:app_atractivos/src/models/hospedaje_model.dart';
import 'package:app_atractivos/src/providers/hospedaje_provider.dart';
import 'package:app_atractivos/src/search/search_hospedaje.dart';
import 'package:app_atractivos/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class HospedajePage extends StatefulWidget {
  @override
  _HospedajePageState createState() => _HospedajePageState();
}

class _HospedajePageState extends State<HospedajePage> {
  final hospedajeProvider = new HospedajeProvider();

  @override
  Widget build(BuildContext context) {
    //final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchHospedaje('Buscar sitios de hospedaje'),
                );
              })
        ],
        title: Text('Hospedaje'),
        centerTitle: true,
        elevation: 4,
      ),
      drawer: MenuWidget(),
      body: Container(
          child: Column(
        children: [
          Expanded(
              child: Stack(
            children: [_crearListado()],
          ))
        ],
      )),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: hospedajeProvider.cargarHospedaje(''),
      builder:
          (BuildContext context, AsyncSnapshot<List<HospedajeModel>> snapshot) {
        if (snapshot.hasData) {
          final hospedaje = snapshot.data;
          return ListView.builder(
            itemCount: hospedaje.length,
            itemBuilder: (context, i) => _crearItem(context, hospedaje[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, HospedajeModel hospedaje) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'detalleHospedaje',
          arguments: hospedaje),
      child: Card(
        elevation: 20.0,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        clipBehavior: Clip.antiAlias,
        //elevation: 0.0,
        child: Column(
          children: [
            (hospedaje.imagenes == null)
                ? Image(image: AssetImage('assets/no-image.png'))
                : FadeInImage(
                    image: NetworkImage(hospedaje.imagenes),
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    height: 200.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            _pieTarjeta(context, hospedaje),
          ],
        ),
      ),
    );
  }

  Widget _pieTarjeta(BuildContext context, HospedajeModel hospedaje) {
    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      child: Column(
        children: [
          ListTile(
            dense: true,
            title: Text('${hospedaje.nombre}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center),
            //subtitle: Text(sitio.id),
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.location_on, color: Colors.red),
            horizontalTitleGap: 0,
            title: Text(
              '${hospedaje.ubicacion}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.attach_money_rounded,
                color: Colors.greenAccent[700]),
            horizontalTitleGap: 0,
            title: Text(
              '${hospedaje.costoNoche}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
            trailing: TextButton(
              child: Text('Más información',
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center),
              onPressed: () => Navigator.pushNamed(context, 'detalleHospedaje',
                  arguments: hospedaje),
            ),
          ),
        ],
      ),
    );
  }
}
