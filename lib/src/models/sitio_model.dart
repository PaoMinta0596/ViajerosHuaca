// To parse this JSON data, do
//
//     final sitiosModel = sitiosModelFromJson(jsonString);

import 'dart:convert';

SitiosModel sitiosModelFromJson(String str) =>
    SitiosModel.fromJson(json.decode(str));

String sitiosModelToJson(SitiosModel data) => json.encode(data.toJson());

class SitiosModel {
  SitiosModel({
    this.id,
    this.nombre = '',
    this.descripcion = '',
    this.ubicacion = '',
    this.imagenes = '',
    this.recorrido = '',
    this.horario = '',
    this.actividades = '',
    this.costo = '',
    this.bioseguridad = '',
    this.telefono = '',
    this.correo = '',
    this.whatsapp = '',
    this.facebook = '',
    this.transporte = '',
    this.mascotas = '',
    this.categoria = '',
    this.coordenadas = '',
  });

  String id;
  String nombre;
  String descripcion;
  String ubicacion;
  String imagenes;
  String recorrido;
  String horario;
  String actividades;
  String costo;
  String bioseguridad;
  String telefono;
  String correo;
  String whatsapp;
  String facebook;
  String transporte;
  String mascotas;
  String categoria;
  String coordenadas;

  factory SitiosModel.fromJson(Map<String, dynamic> json) => SitiosModel(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        ubicacion: json["ubicacion"],
        imagenes: json["imagenes"],
        recorrido: json["recorrido"],
        horario: json["horario"],
        actividades: json["actividades"],
        costo: json["costo"],
        bioseguridad: json["bioseguridad"],
        telefono: json["telefono"],
        correo: json["Correo"],
        whatsapp: json["whatsapp"],
        facebook: json["facebook"],
        transporte: json["transporte"],
        mascotas: json["mascotas"],
        categoria: json["categoria"],
        coordenadas: json["coordenadas"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "ubicacion": ubicacion,
        "imagenes": imagenes,
        "recorrido": recorrido,
        "horario": horario,
        "actividades": actividades,
        "costo": costo,
        "bioseguridad": bioseguridad,
        "telefono": telefono,
        "Correo": correo,
        "whatsapp": whatsapp,
        "facebook": facebook,
        "transporte": transporte,
        "mascotas": mascotas,
        "categoria": categoria,
        "coordenadas": coordenadas,
      };

  // LatLng getLatLng() {
  //   final lalo = coordenadas.substring(0).split(',');
  //   final lat = double.parse(lalo[1]);
  //   final lng = double.parse(lalo[0]);

  //   return LatLng(lat, lng);
  // }
}
