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
                'La parroquia Mariscal Sucre antiguamente conocida como ???Colonia Agropecuaria Popular Huaque??a???, del Cant??n Tulc??n por el propio derecho y mancomunado esfuerzo de sus propios habitantes viene demostrando un avance progresivo dentro de los diferentes aspectos f??sicos, sociales, culturales y econ??micos; elementos b??sicos para la vida y desenvolvimiento de un pueblo.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 15.0),
            Text(
                'El 15 de mayo de 1992 se logra conseguir que la Colonia Popular Huaque??a pase hacer Parroquia Mariscal Sucre; haci??ndola acreedora a todos los privilegios y beneficios que la ley concede para su desenvolvimiento pol??tico y administrativo. Por tal motivo su nombre fue cambiado por parroquia ???MARISCAL SUCRE??? en honor al hombre de confianza del Libertador Sim??n Bol??var.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 15.0),
            Text(
                'Gracias a la Parroquializaci??n de ???Mariscal Sucre???; el 8 de diciembre de 1995 se logr?? la cantonizaci??n de San Pedro de Huaca, pasando a formar parte de esa nueva jurisdicci??n, como la ??nica Parroquia hasta nuestros d??as.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 15.0),
            Text(
                'La econom??a de la Parroquia Mariscal Sucre est?? basada en las actividades agropecuarias y ganaderas, sus tierras est??n dedicadas al monocultivo de papas y pastos. En los ??ltimos a??os se han creado microempresas comunitarias las cuales se dedican a la recepci??n y comercializaci??n de leche.',
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
              'Bandera del Cant??n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
                'El color verde es s??mbolo de la esperanza de sus hijos en un futuro promisorio de honor y gloria.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
                'La franja blanca simboliza la pureza de la ni??ez huaque??a y la plataforma de fe en la Sant??sima Virgen de la Purificaci??n.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
                'El color rojo sintetiza la rebeld??a y el hero??smo de los huacas, cuya sangre ti???? de rojo en la laguna de Yaguarcocha, defendiendo su heredad e identidad de la invasi??n inc??sica.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
                'La estrella blanca peque??a es s??mbolo del esp??ritu filial de los habitantes de la ??nica parroquia Mariscal Sucre.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
                'El fleco dorado es s??mbolo de la riqueza agr??cola y ganadera del suelo y los rayos solares que maduran los campos.',
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
              'Escudo del Cant??n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
                'El escudo en su forma general es una letra U que significa la s??lida unidad de los huaque??os para alcanzar sus gestas gloriosas.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
                'Est?? dividido en tres cuarteles: En el cuartel superior que ocupa la mitad del bal??n se destaca, en el fondo, el hermoso paisaje huaque??o con su eterno centinela el Cerro Mirador.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
                'La monumental copa se levanta gallarda y reluciente, en su parte inferior el pico y la pala, formando una V. En la banda superior una cinta con los colores de la bandera, lleva la inscripci??n cant??n San Pedro de Huaca y su fecha de fundaci??n en letras doradas.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
                'La parte inferior se divide en dos cuarteles donde encontramos un ??dolo coquero que representa la invalorable riqueza arqueol??gica y su gran historia, hacia la derecha tenemos la corona de la Sant??sima Virgen de la Purificaci??n, hacia abajo un libro abierto con una pluma, como demostraci??n de su elevada cultura y erradicaci??n del analfabetismo.',
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
                'Guac??n era el nombre con el cual era conocido este territorio, nombre que proviene, seg??n los historiadores, de la lengua Pasto que significa madre o pueblo antiguo.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
                'La Copa Bayas es uno de los S??mbolos m??s extraordinarios otorgados como un reconocimiento al trabajador huaque??o por su participaci??n en las famosas mingas de construcci??n de la carretera oriental.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
              'La construcci??n de la v??a Tulc??n - Juncal fue decisorio para el pueblo de Huaca. En el sector Chulunguasi, cercano a C??nquer del 25 al 27 de septiembre de 1930 se produjo una de las mingas m??s espectaculares, con la participaci??n de m??s de 15 mil hombres de Julio Andrade, Huaca, Crist??bal Col??n, San Gabriel, La Paz, Bol??var, Garc??a Moreno, San Vicente de Pusir, Mira, San Isidro, Pimampiro, Ambuqu?? y peones de la hacienda de Pim??n.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 10.0),
            Text(
                'Huaca es reconocido por el Ministro de Obras P??blicas, Aurelio Bayas con la Copa, gracias a su esfuerzo y triunfo en las jornadas mingueras, que le llenan de orgullo a sus habitantes quienes con la cantonizaci??n un 8 de diciembre de 1995 se perfilan vencedores hacia el futuro con la mirada altiva como las monta??as que circundan al Cant??n.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 10.0),
            Text(
                'San Pedro de Huaca es un cant??n dedicado principalmente a la ganader??a y agricultura debido a su suelo f??rtil, el cultivo agr??cola m??s importante que debe destacarse es la papa. Es un Cant??n papero y ocupa uno de los primeros lugares en la producci??n nacional de este tub??rculo.',
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
                Text('Pa??s:  ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Ecuador')
              ],
            ),
            Divider(),
            Row(
              children: [
                Text('Regi??n:  ',
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
                    Text('Divisi??n pol??tica: ',
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
                Text('Extensi??n: ',
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
                Text('12??C')
              ],
            ),
            Divider(),
            Row(
              children: [
                Text('Fecha de Cantonizaci??n: ',
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
