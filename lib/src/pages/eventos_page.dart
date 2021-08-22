import 'package:app_atractivos/src/models/eventos_model.dart';
import 'package:app_atractivos/src/providers/eventos_provider.dart';
import 'package:app_atractivos/src/search/search_eventos.dart';
import 'package:app_atractivos/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EventosPage extends StatelessWidget {
  final eventosProvider = new EventosProvider();
  String query = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos'),
        centerTitle: true,
        elevation: 4,
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchEventos('Buscar eventos'),
                );
              })
        ],
      ),
      drawer: MenuWidget(),
      body: Center(
        child: _crearListado(query),
      ),
    );
  }

  Widget _crearListado(String query) {
    return FutureBuilder(
      future: eventosProvider.cargarEventos(query),
      builder:
          (BuildContext context, AsyncSnapshot<List<EventosModel>> snapshot) {
        if (snapshot.hasData) {
          final eventos = snapshot.data;
          return ListView.builder(
            itemCount: eventos.length,
            itemBuilder: (context, i) => _crearItem(context, eventos[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, EventosModel evento) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, 'detalleEventos', arguments: evento),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          margin: EdgeInsets.only(top: 20, bottom: 10),
          width: double.infinity,
          height: 300,
          decoration: _cardBorders(),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              _backgroundImage(context, evento),
              _detallesEvento(evento),

              Positioned(top: 0, right: 0, child: _masInfo()),

              // if( !product.available )
              //   Positioned(
              //     top: 0,
              //     left: 0,
              //     child: _NotAvailable()
              //   ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 7), blurRadius: 10)
          ]);

  Widget _backgroundImage(BuildContext context, EventosModel evento) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 300,
        child: evento.imagenes == null
            ? Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.cover)
            : FadeInImage(
                placeholder: AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(evento.imagenes),
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget _detallesEvento(EventosModel evento) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              evento.nombre,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              evento.fechaInicio,
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
      color: Color(0xff57BC90),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), topRight: Radius.circular(25)));

  Widget _masInfo() {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text('Más Información',
                style: TextStyle(color: Colors.white, fontSize: 25))),
      ),
      width: 120,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xff015249),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), bottomLeft: Radius.circular(25))),
    );
  }
}
