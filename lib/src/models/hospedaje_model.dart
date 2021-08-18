// To parse this JSON data, do
//
//     final hospedajeModel = hospedajeModelFromJson(jsonString);

import 'dart:convert';

HospedajeModel hospedajeModelFromJson(String str) =>
    HospedajeModel.fromJson(json.decode(str));

String hospedajeModelToJson(HospedajeModel data) => json.encode(data.toJson());

class HospedajeModel {
  HospedajeModel({
    this.id,
    this.nombre,
    this.descripcion,
    this.ubicacion,
    this.imagenes,
    this.coordenadas,
    this.horario,
    this.costoNoche,
    this.telefono,
    this.correo,
    this.whatsapp,
    this.facebook,
    this.mascotas,
    this.wifi,
  });

  String id;
  String nombre;
  String descripcion;
  String ubicacion;
  String imagenes;
  String coordenadas;
  String horario;
  String costoNoche;
  String telefono;
  String correo;
  String whatsapp;
  String facebook;
  String mascotas;
  String wifi;

  factory HospedajeModel.fromJson(Map<String, dynamic> json) => HospedajeModel(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        ubicacion: json["ubicacion"],
        imagenes: json["imagenes"],
        coordenadas: json["coordenadas"],
        horario: json["horario"],
        costoNoche: json["costoNoche"],
        telefono: json["telefono"],
        correo: json["Correo"],
        whatsapp: json["whatsapp"],
        facebook: json["facebook"],
        mascotas: json["mascotas"],
        wifi: json["wifi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "ubicacion": ubicacion,
        "imagenes": imagenes,
        "coordenadas": coordenadas,
        "horario": horario,
        "costoNoche": costoNoche,
        "telefono": telefono,
        "Correo": correo,
        "whatsapp": whatsapp,
        "facebook": facebook,
        "mascotas": mascotas,
        "wifi": wifi,
      };
}
