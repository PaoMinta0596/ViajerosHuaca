import 'package:app_atractivos/src/bloc/provider.dart';
import 'package:app_atractivos/src/bloc/theme.dart';
import 'package:app_atractivos/src/pages/abrir_enlace_page.dart';
import 'package:app_atractivos/src/pages/alimentacion_page.dart';
import 'package:app_atractivos/src/pages/detalle_alimentacion_page.dart';
import 'package:app_atractivos/src/pages/detalle_eventos_page.dart';
import 'package:app_atractivos/src/pages/detalle_gastronomia.dart';
import 'package:app_atractivos/src/pages/detalle_hospedaje_page.dart';
import 'package:app_atractivos/src/pages/detalle_transporte_page.dart';
import 'package:app_atractivos/src/pages/emergencias_page.dart';
import 'package:app_atractivos/src/pages/eventos_page.dart';
import 'package:app_atractivos/src/pages/gastronomia_page.dart';
import 'package:app_atractivos/src/pages/hospedaje_page.dart';
import 'package:app_atractivos/src/pages/informacion_page.dart';
import 'package:app_atractivos/src/pages/mapa_general.dart';
import 'package:app_atractivos/src/pages/mapa_page.dart';
import 'package:app_atractivos/src/pages/registro_page.dart';
import 'package:app_atractivos/src/pages/sitios_page.dart';
import 'package:app_atractivos/src/pages/transporte_page.dart';
import 'package:app_atractivos/src/pages/usuario_page.dart';
import 'package:app_atractivos/src/preferencias_usuario.dart/preferencias_usuario.dart';
import 'package:app_atractivos/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_atractivos/src/pages/detalle_sitio_page.dart';
import 'package:app_atractivos/src/pages/home_page.dart';
import 'package:app_atractivos/src/pages/login_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    // print(prefs.token);
    return ProviderUs(
      child: ChangeNotifierProvider(
        create: (context) => ThemeNotifier(),
        child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
            return MaterialApp(
              theme: notifier.darkTheme ? dark : light,
              debugShowCheckedModeBanner: false,
              title: 'Viajeros Huaca',
              initialRoute: prefs.ultimaPagina,
              routes: {
                'login': (BuildContext context) => LoginPage(),
                'registro': (BuildContext context) => RegistroPage(),
                'menu': (BuildContext context) => MenuWidget(),
                'mapa': (BuildContext context) => MapaPage(),
                'home': (BuildContext context) => HomePage(),
                'usuario': (BuildContext context) => UsuarioPage(),
                'sitios': (BuildContext context) => SitiosPage(),
                'detalleSitio': (BuildContext context) => DetalleSitioPage(),
                'hospedaje': (BuildContext context) => HospedajePage(),
                'gastronomia': (BuildContext context) => GastronomiaPage(),
                'detalleGastronomia': (BuildContext context) =>
                    DetalleGastronomiaPage(),
                'detalleHospedaje': (BuildContext context) =>
                    DetalleHospedajePage(),
                'alimentacion': (BuildContext context) => AlimentacionPage(),
                'detalleAlimentacion': (BuildContext context) =>
                    DetalleAlimentacionPage(),
                'transporte': (BuildContext context) => TransportePage(),
                'detalleTransporte': (BuildContext context) =>
                    DetalleTransportePage(),
                'eventos': (BuildContext context) => EventosPage(),
                'detalleEventos': (BuildContext context) =>
                    DetalleEventosPage(),
                'informacion': (BuildContext context) => InformacionPage(),
                'emergencias': (BuildContext context) => EmergenciasPage(),
                'abrirEnlace': (BuildContext context) => AbrirEnlace(),
                'mapaGeneral': (BuildContext context) => MapaGeneralPage()
              },
              // theme: ThemeData(primaryColor: Color(0xff57BC90)),
            );
          },
        ),
      ),
    );
  }
}
