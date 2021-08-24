import 'package:app_atractivos/src/preferencias_usuario.dart/preferencias_usuario.dart';
import 'package:app_atractivos/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = 'home';
    return Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: Text('Inicio'),
          centerTitle: true,
        ),
        drawer: MenuWidget(),
        body: Container(
          child: Column(
            children: [
              _portada(context),
              Expanded(child: SingleChildScrollView(child: _mensaje()))
            ],
          ),
        ));
  }

  Widget _portada(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/portada.jpg',
        width: double.infinity,
      ),
    );
  }

  Widget _mensaje() {
    return Container(
      padding: EdgeInsets.all(30.0),
      width: double.infinity,
      child: Column(
        children: [
          Text('San Pedro de Huaca',
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 30.0),
          Text(
            'El cantón se mantiene siempre vivo por sus fiestas y tradiciones, siendo sede de uno de los Santuarios más admirados de la provincia, el Santuario de la Virgen de la Purificación, pureza que se ve reflejada en el corazón de su gente. Es un cantón de espectacular ecosistema y jardines de frailejones en su páramo, aquí podrás encontrar lugares mágicos e increíbles que tal vez aún no conozcas. No esperes más, ven y visítanos.',
            style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
