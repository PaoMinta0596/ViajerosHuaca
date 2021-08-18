import 'package:app_atractivos/src/models/eventos_model.dart';
import 'package:app_atractivos/src/providers/eventos_provider.dart';
import 'package:flutter/material.dart';

class SearchEventos extends SearchDelegate {
  @override
  final String searchFieldLabel;
  SearchEventos(this.searchFieldLabel);
  final eventosProvider = new EventosProvider();

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
          future: eventosProvider.cargarEventos(query),
          builder: (BuildContext context,
              AsyncSnapshot<List<EventosModel>> snapshot) {
            if (snapshot.hasData) {
              final eventos = snapshot.data;
              return ListView(
                  children: eventos.map((evento) {
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(evento.imagenes),
                    placeholder: AssetImage('assets/no-image.png'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(evento.nombre),
                  subtitle: Text(evento.ubicacion),
                  onTap: () {
                    close(context, null);
                    Navigator.pushNamed(context, 'detalleEventos',
                        arguments: evento);
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
