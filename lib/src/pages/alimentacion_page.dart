import 'package:app_atractivos/src/models/alimentacion_model.dart';
import 'package:app_atractivos/src/providers/alimentacion_provider.dart';
import 'package:app_atractivos/src/search/search_alimentacion.dart';
import 'package:app_atractivos/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class AlimentacionPage extends StatefulWidget {
  @override
  _AlimentacionPageState createState() => _AlimentacionPageState();
}

class _AlimentacionPageState extends State<AlimentacionPage> {
  final alimentacionProvider = new AlimentacionProvider();

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
                  delegate: SearchAlimentacion('Buscar sitios de alimentación'),
                );
              })
        ],
        title: Text('Alimentación'),
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
      future: alimentacionProvider.cargarAlimentacion(''),
      builder: (BuildContext context,
          AsyncSnapshot<List<AlimentacionModel>> snapshot) {
        if (snapshot.hasData) {
          final alimentacion = snapshot.data;
          return ListView.builder(
            itemCount: alimentacion.length,
            itemBuilder: (context, i) => _crearItem(context, alimentacion[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, AlimentacionModel alimentacion) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'detalleAlimentacion',
          arguments: alimentacion),
      child: Card(
        elevation: 20.0,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        clipBehavior: Clip.antiAlias,
        //elevation: 0.0,
        child: Column(
          children: [
            (alimentacion.imagenes == null)
                ? Image(image: AssetImage('assets/no-image.png'))
                : FadeInImage(
                    image: NetworkImage(alimentacion.imagenes),
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    height: 200.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            _pieTarjeta(context, alimentacion),
          ],
        ),
      ),
    );
  }

  Widget _pieTarjeta(BuildContext context, AlimentacionModel alimentacion) {
    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      child: Column(
        children: [
          ListTile(
            dense: true,
            title: Text('${alimentacion.nombre}',
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
              '${alimentacion.ubicacion}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.access_time_rounded, color: Colors.blue[600]),
            horizontalTitleGap: 0,
            title: Text(
              '${alimentacion.horario}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
            trailing: TextButton(
              child: Text('Más información',
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center),
              onPressed: () => Navigator.pushNamed(
                  context, 'detalleAlimentacion',
                  arguments: alimentacion),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget _searchBox() {
//   return Container(
//     margin: EdgeInsets.only(right: 20.0, left: 20.0, top: 0, bottom: 10.0),
//     padding: EdgeInsets.symmetric(
//       horizontal: 20.0,
//     ),
//     decoration: BoxDecoration(
//       color: Colors.white.withOpacity(0.4),
//       borderRadius: BorderRadius.circular(20),
//     ),
//     child: TextField(
//       //onChanged: onChanged,
//       //style: TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         enabledBorder: InputBorder.none,
//         focusedBorder: InputBorder.none,
//         icon: Icon(
//           Icons.search_rounded,
//           color: Color(0xff015249),
//         ),
//         hintText: 'Search',
//         hintStyle: TextStyle(color: Colors.white),
//       ),
//       onTap: () {},
//     ),
//   );
// }
