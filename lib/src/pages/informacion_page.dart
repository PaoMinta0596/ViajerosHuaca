// import 'dart:html';

import 'package:app_atractivos/src/models/slider_model.dart';
import 'package:app_atractivos/src/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InformacionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new SliderModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('San Pedro de Huaca'),
          centerTitle: true,
          elevation: 4,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.home,
                  size: 35,
                ),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'home'))
          ],
        ),
        drawer: MenuWidget(),
        body: Center(
          child: Column(children: [Expanded(child: _Slides()), _Dots()]),
        ),
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageViewController = new PageController();

  @override
  void initState() {
    super.initState();

    pageViewController.addListener(() {
      //actualizar el provider. sliderModel
      Provider.of<SliderModel>(context, listen: false).currentPage =
          pageViewController.page;
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageViewController,
        children: [
          _DatosGenerales(),
          _Escudo(),
          _Bandera(),
          _HistoriaHuaca(),
          _HistoriaMariscal()
        ],
      ),
    );
  }
}

class _HistoriaMariscal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 30, right: 30, top: 20),
        child: Column(
          children: [
            Text('Historia de Mariscal Sucre',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 15.0),
            Text(
                'La parroquia Mariscal Sucre antiguamente conocida como “Colonia Agropecuaria Popular Huaqueña”, del Cantón Tulcán por el propio derecho y mancomunado esfuerzo de sus propios habitantes viene demostrando un avance progresivo dentro de los diferentes aspectos físicos, sociales, culturales y económicos; elementos básicos para la vida y desenvolvimiento de un pueblo.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 15.0),
            Text(
                'El 15 de mayo de 1992 se logra conseguir que la Colonia Popular Huaqueña pase hacer Parroquia Mariscal Sucre; haciéndola acreedora a todos los privilegios y beneficios que la ley concede para su desenvolvimiento político y administrativo. Por tal motivo su nombre fue cambiado por parroquia “MARISCAL SUCRE” en honor al hombre de confianza del Libertador Simón Bolívar.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 15.0),
            Text(
                'Gracias a la Parroquialización de “Mariscal Sucre”; el 8 de diciembre de 1995 se logró la cantonización de San Pedro de Huaca, pasando a formar parte de esa nueva jurisdicción, como la única Parroquia hasta nuestros días.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 15.0),
            Text(
                'La economía de la Parroquia Mariscal Sucre está basada en las actividades agropecuarias y ganaderas, sus tierras están dedicadas al monocultivo de papas y pastos. En los últimos años se han creado microempresas comunitarias las cuales se dedican a la recepción y comercialización de leche.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}

class _Bandera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 30, right: 30, top: 10),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(180.0)),
              clipBehavior: Clip.antiAlias,
              elevation: 15,
              child: FadeInImage(
                image: NetworkImage(
                    'https://res.cloudinary.com/dgn9qbfmo/image/upload/v1624047691/bandera_sxd9um.png'),
                placeholder: AssetImage('assets/jar-loading.gif'),
                height: 200,
                width: 200,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Bandera del Cantón',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
                'El color verde es símbolo de la esperanza de sus hijos en un futuro promisorio de honor y gloria.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
                'La franja blanca simboliza la pureza de la niñez huaqueña y la plataforma de fe en la Santísima Virgen de la Purificación.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
                'El color rojo sintetiza la rebeldía y el heroísmo de los huacas, cuya sangre tiñó de rojo en la laguna de Yaguarcocha, defendiendo su heredad e identidad de la invasión incásica.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
                'La estrella blanca pequeña es símbolo del espíritu filial de los habitantes de la única parroquia Mariscal Sucre.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
                'El fleco dorado es símbolo de la riqueza agrícola y ganadera del suelo y los rayos solares que maduran los campos.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
                'El asta representa la herramienta fundamental del magno triunfo en la gran minga de la carretera oriental en 1936.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}

class _Escudo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 30, right: 30, top: 10),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(180.0)),
              clipBehavior: Clip.antiAlias,
              elevation: 15,
              child: FadeInImage(
                image: NetworkImage(
                    'https://res.cloudinary.com/dgn9qbfmo/image/upload/v1624047682/escudo_cuigx7.png'),
                placeholder: AssetImage('assets/jar-loading.gif'),
                height: 200,
                width: 200,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Escudo del Cantón',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
                'El escudo en su forma general es una letra U que significa la sólida unidad de los huaqueños para alcanzar sus gestas gloriosas.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
                'Está dividido en tres cuarteles: En el cuartel superior que ocupa la mitad del balón se destaca, en el fondo, el hermoso paisaje huaqueño con su eterno centinela el Cerro Mirador.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
                'La monumental copa se levanta gallarda y reluciente, en su parte inferior el pico y la pala, formando una V. En la banda superior una cinta con los colores de la bandera, lleva la inscripción cantón San Pedro de Huaca y su fecha de fundación en letras doradas.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
                'La parte inferior se divide en dos cuarteles donde encontramos un ídolo coquero que representa la invalorable riqueza arqueológica y su gran historia, hacia la derecha tenemos la corona de la Santísima Virgen de la Purificación, hacia abajo un libro abierto con una pluma, como demostración de su elevada cultura y erradicación del analfabetismo.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}

class _HistoriaHuaca extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 30, right: 30, top: 20),
        child: Column(
          children: [
            Text('Historia de Huaca',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 15.0),
            Text(
                'Guacán era el nombre con el cual era conocido este territorio, nombre que proviene, según los historiadores, de la lengua Pasto que significa madre o pueblo antiguo.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
                'La Copa Bayas es uno de los Símbolos más extraordinarios otorgados como un reconocimiento al trabajador huaqueño por su participación en las famosas mingas de construcción de la carretera oriental.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
              'La construcción de la vía Tulcán - Juncal fue decisorio para el pueblo de Huaca. En el sector Chulunguasi, cercano a Cúnquer del 25 al 27 de septiembre de 1930 se produjo una de las mingas más espectaculares, con la participación de más de 15 mil hombres de Julio Andrade, Huaca, Cristóbal Colón, San Gabriel, La Paz, Bolívar, García Moreno, San Vicente de Pusir, Mira, San Isidro, Pimampiro, Ambuquí y peones de la hacienda de Pimán.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 10.0),
            Text(
                'Huaca es reconocido por el Ministro de Obras Públicas, Aurelio Bayas con la Copa, gracias a su esfuerzo y triunfo en las jornadas mingueras, que le llenan de orgullo a sus habitantes quienes con la cantonización un 8 de diciembre de 1995 se perfilan vencedores hacia el futuro con la mirada altiva como las montañas que circundan al Cantón.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
                'San Pedro de Huaca es un cantón dedicado principalmente a la ganadería y agricultura debido a su suelo fértil, el cultivo agrícola más importante que debe destacarse es la papa. Es un Cantón papero y ocupa uno de los primeros lugares en la producción nacional de este tubérculo.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}

class _DatosGenerales extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 30, right: 30, top: 10),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(180.0)),
              clipBehavior: Clip.antiAlias,
              elevation: 15,
              child: FadeInImage(
                image: NetworkImage(
                    'https://res.cloudinary.com/dgn9qbfmo/image/upload/v1624047656/logo_ncz3ew.jpg'),
                placeholder: AssetImage('assets/jar-loading.gif'),
                height: 200,
                width: 200,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Datos generales',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Text('País:  ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Ecuador')
              ],
            ),
            Divider(),
            Row(
              children: [
                Text('Región:  ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Andina')
              ],
            ),
            Divider(),
            Row(
              children: [
                Text('Provicia: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Carchi')
              ],
            ),
            Divider(),
            Column(
              children: [
                Row(
                  children: [
                    Text('División política: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Huaca (cabecera cantonal)')
                  ],
                ),
                Text('              Mariscal Sucre (parroquia rural)')
              ],
            ),
            Divider(),
            Row(
              children: [
                Text('Extensión: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('76,32 Km2')
              ],
            ),
            Divider(),
            Row(
              children: [
                Text('Latitud: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('0.634237')
              ],
            ),
            Divider(),
            Row(
              children: [
                Text('Longitud: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('-77.724769')
              ],
            ),
            Divider(),
            Row(
              children: [
                Text('Altura: ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('2.950 m.s.n.m.')
              ],
            ),
            Divider(),
            Row(
              children: [
                Text('Temperatura promedio: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('12°C')
              ],
            ),
            Divider(),
            Row(
              children: [
                Text('Fecha de Cantonización: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('8 de Diciembre de 1995')
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_Dot(0), _Dot(1), _Dot(2), _Dot(3), _Dot(4)],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  _Dot(this.index);
  @override
  Widget build(BuildContext context) {
    final pageViewIndex = Provider.of<SliderModel>(context).currentPage;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: 12,
      height: 12,
      margin: EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
          color: (pageViewIndex >= index - 0.5 && pageViewIndex < index + 0.5)
              ? Colors.green
              : Colors.grey,
          shape: BoxShape.circle),
    );
  }
}

// class _Barra extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 55,
//       child: Row(
//         children: [
//           IconButton(
//               icon: Icon(Icons.arrow_back_rounded),
//               onPressed: () => Navigator.of(context).pop())
//         ],
//       ),
//     );
//   }
// }
