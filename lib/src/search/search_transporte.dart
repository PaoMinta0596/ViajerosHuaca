import 'package:app_atractivos/src/models/transporte_model.dart';
import 'package:app_atractivos/src/providers/transporte_provider.dart';
import 'package:flutter/material.dart';

class SearchTransporte extends SearchDelegate {
  @override
  final String searchFieldLabel;
  SearchTransporte(this.searchFieldLabel);
  final transporteProvider = new TransporteProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // las acciones de nuestro appbar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  // ignore: missing_return
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Las sugerencias que aparecen cuando la persona escribe

    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
          future: transporteProvider.cargarTransporte(query),
          builder: (BuildContext context,
              AsyncSnapshot<List<TransporteModel>> snapshot) {
            if (snapshot.hasData) {
              final transportes = snapshot.data;
              return ListView(
                  children: transportes.map((transporte) {
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(transporte.imagenes),
                    placeholder: AssetImage('assets/no-image.png'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(transporte.nombre),
                  subtitle: Text(transporte.horario),
                  onTap: () {
                    close(context, null);
                    Navigator.pushNamed(context, 'detalleTransporte',
                        arguments: transporte);
                  },
                );
              }).toList());
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    }
  }
}
