import 'package:app_atractivos/src/models/alimentacion_model.dart';
import 'package:app_atractivos/src/providers/alimentacion_provider.dart';
import 'package:flutter/material.dart';

class SearchAlimentacion extends SearchDelegate {
  @override
  final String searchFieldLabel;
  SearchAlimentacion(this.searchFieldLabel);
  final alimentacionProvider = new AlimentacionProvider();

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
          future: alimentacionProvider.cargarAlimentacion(query),
          builder: (BuildContext context,
              AsyncSnapshot<List<AlimentacionModel>> snapshot) {
            if (snapshot.hasData) {
              final alimentaciones = snapshot.data;
              return ListView(
                  children: alimentaciones.map((alimentacion) {
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(alimentacion.imagenes),
                    placeholder: AssetImage('assets/no-image.png'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(alimentacion.nombre),
                  subtitle: Text(alimentacion.ubicacion),
                  onTap: () {
                    close(context, null);
                    Navigator.pushNamed(context, 'detalleAlimentacion',
                        arguments: alimentacion);
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
