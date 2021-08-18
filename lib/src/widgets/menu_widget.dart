import 'package:app_atractivos/src/bloc/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuWidget extends StatefulWidget {
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: EdgeInsets.only(top: 20.0, bottom: 10),
            height: 130,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[Color(0xff015249), Color(0xff57BC90)]),
              // color: Color(0xff77c9d4),
            ),
            child: Image.asset('assets/VIAJEROS.png'),
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.home_rounded, color: Color(0xff015249)),
            title: Text('Inicio', style: TextStyle(fontSize: 14)),
            onTap: () => Navigator.pushReplacementNamed(context, 'home'),
          ),
          ListTile(
              dense: true,
              leading: Icon(Icons.person, color: Color(0xff015249)),
              title: Text('Mi perfil', style: TextStyle(fontSize: 14)),
              onTap: () => Navigator.pushNamed(context, 'usuario')),
          ListTile(
              dense: true,
              leading: Icon(Icons.attractions, color: Color(0xff015249)),
              title: Text('Sitios Turísticos', style: TextStyle(fontSize: 14)),
              onTap: () => Navigator.pushNamed(context, 'sitios')),
          ListTile(
              dense: true,
              leading: Icon(Icons.threesixty_rounded, color: Color(0xff015249)),
              title: Text('Gastronomía', style: TextStyle(fontSize: 14)),
              onTap: () => Navigator.pushNamed(context, 'gastronomia')),
          ListTile(
              dense: true,
              leading: Icon(Icons.calendar_today, color: Color(0xff015249)),
              title: Text('Eventos', style: TextStyle(fontSize: 14)),
              onTap: () => Navigator.pushNamed(context, 'eventos')),
          ListTile(
            dense: true,
            leading: Icon(Icons.local_hotel, color: Color(0xff015249)),
            title: Text('Hospedaje', style: TextStyle(fontSize: 14)),
            onTap: () => Navigator.pushNamed(context, 'hospedaje'),
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.food_bank_rounded, color: Color(0xff015249)),
            title: Text('Alimentación', style: TextStyle(fontSize: 14)),
            onTap: () => Navigator.pushNamed(context, 'alimentacion'),
          ),
          ListTile(
              dense: true,
              leading: Icon(Icons.directions_bus, color: Color(0xff015249)),
              title: Text('Transporte', style: TextStyle(fontSize: 14)),
              onTap: () => Navigator.pushNamed(context, 'transporte')),
          ListTile(
            dense: true,
            leading: Icon(Icons.map_outlined, color: Color(0xff015249)),
            title: Text('Mapa del cantón', style: TextStyle(fontSize: 14)),
            onTap: () => Navigator.pushNamed(context, 'mapaGeneral'),
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.info, color: Color(0xff015249)),
            title: Text('Acerca de Huaca', style: TextStyle(fontSize: 14)),
            onTap: () => Navigator.pushNamed(context, 'informacion'),
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.policy, color: Color(0xff015249)),
            title: Text('Emergencias', style: TextStyle(fontSize: 14)),
            onTap: () => Navigator.pushNamed(context, 'emergencias'),
          ),
          SizedBox(height: 10),
          Consumer<ThemeNotifier>(
            builder: (context, notifier, child) => SwitchListTile(
                title: Text('Modo Oscuro'),
                onChanged: (value) {
                  notifier.toggleTheme();
                },
                value: notifier.darkTheme),
          )
        ],
      ),
    );
  }
}
