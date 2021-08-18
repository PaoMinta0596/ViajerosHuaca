//import 'package:app_atractivos/src/bloc/provider.dart';
import 'package:app_atractivos/src/models/sitio_model.dart';
import 'package:app_atractivos/src/providers/sitios_provider.dart';
import 'package:app_atractivos/src/search/search_delegate.dart';
import 'package:app_atractivos/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class SitiosPage extends StatefulWidget {
  @override
  _SitiosPageState createState() => _SitiosPageState();
}

class _SitiosPageState extends State<SitiosPage> {
  final sitiosProvider = new SitiosProvider();
  int selectedIndex = 0;
  String query = '';
  //bool isPressed = true;
  List categorias = ['Todos', 'Naturales', 'Culturales'];

  @override
  Widget build(BuildContext context) {
    // final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sitios turísticos'),
        centerTitle: true,
        elevation: 4,
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: DataSearch('Buscar sitio'),
                );
              })
        ],
      ),
      // backgroundColor: Color(0xff57BC90),
      drawer: MenuWidget(),
      body: Container(
          child: Column(
        children: [
          _categorias(context),
          Expanded(
              child: Stack(
            children: [_crearListado(query)],
          ))
        ],
      )),
    );
  }

  Widget _categorias(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 30.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categorias.length,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    if (index == 0) {
                      query = '';
                    } else {
                      query = categorias[index];
                    }
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      left: 10.0,
                      right: index == categorias.length - 1 ? 20.0 : 0),
                  padding: EdgeInsets.symmetric(horizontal: 22.0),
                  decoration: BoxDecoration(
                      color: index == selectedIndex
                          ? Colors.greenAccent[400].withOpacity(0.3)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(7)),
                  child: Text(
                    categorias[index],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )),
    );
  }

  Widget _crearListado(String query) {
    return FutureBuilder(
      future: sitiosProvider.buscarSitios(query),
      builder:
          (BuildContext context, AsyncSnapshot<List<SitiosModel>> snapshot) {
        if (snapshot.hasData) {
          final sitios = snapshot.data;
          return ListView.builder(
            itemCount: sitios.length,
            itemBuilder: (context, i) => _crearItem(context, sitios[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, SitiosModel sitio) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, 'detalleSitio', arguments: sitio),
      child: Card(
        elevation: 20.0,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        clipBehavior: Clip.antiAlias,
        //elevation: 0.0,
        child: Column(
          children: [
            (sitio.imagenes == null)
                ? Image(image: AssetImage('assets/no-image.png'))
                : FadeInImage(
                    image: NetworkImage(sitio.imagenes),
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    height: 200.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            _pieTarjeta(context, sitio),
          ],
        ),
      ),
    );
  }

  Widget _pieTarjeta(BuildContext context, SitiosModel sitio) {
    return Container(
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        child: Column(
          children: [
            ListTile(
              dense: true,
              title: Text('${sitio.nombre}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
              //subtitle: Text(sitio.id),
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.timer_rounded, color: Colors.lightBlue),
              horizontalTitleGap: 0,
              title: Text(
                '${sitio.horario}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.attach_money_rounded,
                  color: Colors.greenAccent[700]),
              horizontalTitleGap: 0,
              title: Text(
                '${sitio.costo}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16),
              ),
              trailing: TextButton(
                child: Text('Más información',
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center),
                onPressed: () => Navigator.pushNamed(context, 'detalleSitio',
                    arguments: sitio),
              ),
            ),
          ],
        ));
  }
}
