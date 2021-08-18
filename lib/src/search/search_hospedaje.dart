import 'package:app_atractivos/src/models/hospedaje_model.dart';
import 'package:app_atractivos/src/providers/hospedaje_provider.dart';
import 'package:flutter/material.dart';

class SearchHospedaje extends SearchDelegate {
  @override
  final String searchFieldLabel;
  SearchHospedaje(this.searchFieldLabel);
  final hospedajeProvider = new HospedajeProvider();

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
          future: hospedajeProvider.cargarHospedaje(query),
          builder: (BuildContext context,
              AsyncSnapshot<List<HospedajeModel>> snapshot) {
            if (snapshot.hasData) {
              final hospedajes = snapshot.data;
              return ListView(
                  children: hospedajes.map((hospedaje) {
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(hospedaje.imagenes),
                    placeholder: AssetImage('assets/no-image.png'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(hospedaje.nombre),
                  subtitle: Text(hospedaje.horario),
                  onTap: () {
                    close(context, null);
                    Navigator.pushNamed(context, 'detalleHospedaje',
                        arguments: hospedaje);
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
