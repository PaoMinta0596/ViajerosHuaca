import 'package:app_atractivos/src/models/sitio_model.dart';
import 'package:app_atractivos/src/providers/sitios_provider.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  @override
  final String searchFieldLabel;
  DataSearch(this.searchFieldLabel);
  final sitiosProvider = new SitiosProvider();

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
          future: sitiosProvider.buscarSitios(query),
          builder: (BuildContext context,
              AsyncSnapshot<List<SitiosModel>> snapshot) {
            if (snapshot.hasData) {
              final sitios = snapshot.data;
              return ListView(
                  children: sitios.map((sitio) {
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(sitio.imagenes),
                    placeholder: AssetImage('assets/no-image.png'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(sitio.nombre),
                  subtitle: Text(sitio.categoria),
                  onTap: () {
                    close(context, null);
                    Navigator.pushNamed(context, 'detalleSitio',
                        arguments: sitio);
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
