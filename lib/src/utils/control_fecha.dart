fechaCaducada(String fechaFin) {
  String texto;
  DateTime hoy = DateTime.now();
  int anioActual = hoy.year;
  int mesActual = hoy.month;
  int diaActual = hoy.day;

  final fechaIni = fechaFin.substring(0).split('-');
  int anioInicio = int.parse(fechaIni[0]);
  int mesInicio = int.parse(fechaIni[1]);
  int diaInicio = int.parse(fechaIni[2]);

  if (anioInicio > anioActual) {
    texto = 'Estás a tiempo de asistir';
  } else {
    if (anioInicio < anioActual) {
      texto = 'El evento ya caducó';
    } else {
      if (anioInicio == anioActual) {
        if (mesInicio > mesActual) {
          texto = 'Estás a tiempo de asistir';
        } else {
          if (mesInicio < mesActual) {
            texto = 'El evento ya caducó';
          } else {
            if (mesInicio == mesActual) {
              if (diaInicio > diaActual) {
                texto = 'Estás a tiempo de asistir';
              } else {
                texto = 'El evento ya caducó';
              }
            }
          }
        }
      }
    }
  }

  return texto;
}
