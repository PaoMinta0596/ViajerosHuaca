import 'package:app_atractivos/src/models/transporte_model.dart';
import 'package:app_atractivos/src/providers/transporte_provider.dart';
import 'package:app_atractivos/src/search/search_transporte.dart';
import 'package:app_atractivos/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class TransportePage extends StatefulWidget {
  @override
  _TransportePageState createState() => _TransportePageState();
}

class _TransportePageState extends State<TransportePage> {
  final transporteProvider = new TransporteProvider();

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
                  delegate: SearchTransporte('Buscar medios de transporte'),
                );
              })
        ],
        title: Text('Transporte'),
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
      future: transporteProvider.cargarTransporte(''),
      builder: (BuildContext context,
          AsyncSnapshot<List<TransporteModel>> snapshot) {
        if (snapshot.hasData) {
          final transporte = snapshot.data;
          return ListView.builder(
            itemCount: transporte.length,
            itemBuilder: (context, i) => _crearItem(context, transporte[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, TransporteModel transporte) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'detalleTransporte',
          arguments: transporte),
      child: Card(
        elevation: 20.0,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        clipBehavior: Clip.antiAlias,
        //elevation: 0.0,
        child: Column(
          children: [
            (transporte.imagenes == null)
                ? Image(image: AssetImage('assets/no-image.png'))
                : FadeInImage(
                    image: NetworkImage(transporte.imagenes),
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    height: 200.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            _pieTarjeta(context, transporte),
          ],
        ),
      ),
    );
  }

  Widget _pieTarjeta(BuildContext context, TransporteModel transporte) {
    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      child: Column(
        children: [
          ListTile(
            dense: true,
            title: Text('${transporte.nombre}',
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
              '${transporte.ubicacion}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.access_time_rounded, color: Colors.blue[600]),
            horizontalTitleGap: 0,
            title: Text(
              '${transporte.horario}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
            trailing: TextButton(
              child: Text('Más información',
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center),
              onPressed: () => Navigator.pushNamed(context, 'detalleTransporte',
                  arguments: transporte),
            ),
          ),
        ],
      ),
    );
  }
}
