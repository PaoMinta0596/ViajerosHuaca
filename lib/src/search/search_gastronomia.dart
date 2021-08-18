import 'package:app_atractivos/src/models/gastronomia_model.dart';
import 'package:app_atractivos/src/providers/gastronomia_provider.dart';
import 'package:flutter/material.dart';

class SearchGastronomia extends SearchDelegate {
  @override
  final String searchFieldLabel;
  SearchGastronomia(this.searchFieldLabel);
  final gastronomiaProvider = new GastronomiaProvider();

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
          future: gastronomiaProvider.cargarGastronomia(query),
          builder: (BuildContext context,
              AsyncSnapshot<List<GastronomiaModel>> snapshot) {
            if (snapshot.hasData) {
              final gastronomias = snapshot.data;
              return ListView(
                  children: gastronomias.map((gastronomia) {
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(gastronomia.imagenes),
                    placeholder: AssetImage('assets/no-image.png'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(gastronomia.nombre),
                  // subtitle: Text(gastronomia.costo),
                  onTap: () {
                    close(context, null);
                    Navigator.pushNamed(context, 'detalleGastronomia',
                        arguments: gastronomia);
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
