import 'package:app_atractivos/src/models/gastronomia_model.dart';
import 'package:app_atractivos/src/providers/gastronomia_provider.dart';
import 'package:app_atractivos/src/search/search_gastronomia.dart';
import 'package:app_atractivos/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GastronomiaPage extends StatelessWidget {
  final gastronomiaProvider = new GastronomiaProvider();
  String query = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gastronomía del Cantón'),
        centerTitle: true,
        elevation: 4,
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchGastronomia('Buscar platos gastronómicos'),
                );
              })
        ],
      ),
      drawer: MenuWidget(),
      body: Center(child: _crearListado(query)),
    );
  }

  Widget _crearListado(String query) {
    return FutureBuilder(
      future: gastronomiaProvider.cargarGastronomia(query),
      builder: (BuildContext context,
          AsyncSnapshot<List<GastronomiaModel>> snapshot) {
        if (snapshot.hasData) {
          final gastronomia = snapshot.data;
          return ListView.builder(
            itemCount: gastronomia.length,
            itemBuilder: (context, i) => _crearItem(context, gastronomia[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, GastronomiaModel gastronomia) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'detalleGastronomia',
          arguments: gastronomia),
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
              _backgroundImage(context, gastronomia),
              _detallesGastronomia(gastronomia),
              Positioned(top: 0, right: 0, child: _masInfo()),
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

  Widget _backgroundImage(BuildContext context, GastronomiaModel gastronomia) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 300,
        child: gastronomia.imagenes == null
            ? Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.cover)
            : FadeInImage(
                placeholder: AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(gastronomia.imagenes),
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget _detallesGastronomia(GastronomiaModel gastronomia) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              gastronomia.nombre,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
