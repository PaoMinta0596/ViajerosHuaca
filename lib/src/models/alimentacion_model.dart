// To parse this JSON data, do
//
//     final alimentacionModel = alimentacionModelFromJson(jsonString);

import 'dart:convert';

AlimentacionModel alimentacionModelFromJson(String str) =>
    AlimentacionModel.fromJson(json.decode(str));

String alimentacionModelToJson(AlimentacionModel data) =>
    json.encode(data.toJson());

class AlimentacionModel {
  AlimentacionModel({
    this.id,
    this.nombre,
    this.descripcion,
    this.ubicacion,
    this.imagenes,
    this.coordenadas,
    this.horario,
    this.menu,
    this.telefono,
    this.whatsapp,
    this.facebook,
  });

  String id;
  String nombre;
  String descripcion;
  String ubicacion;
  String imagenes;
  String coordenadas;
  String horario;
  String menu;
  String telefono;
  String whatsapp;
  String facebook;

  factory AlimentacionModel.fromJson(Map<String, dynamic> json) =>
      AlimentacionModel(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        ubicacion: json["ubicacion"],
        imagenes: json["imagenes"],
        coordenadas: json["coordenadas"],
        horario: json["horario"],
        menu: json["menu"],
        telefono: json["telefono"],
        whatsapp: json["whatsapp"],
        facebook: json["facebook"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "ubicacion": ubicacion,
        "imagenes": imagenes,
        "coordenadas": coordenadas,
        "horario": horario,
        "menu": menu,
        "telefono": telefono,
        "whatsapp": whatsapp,
        "facebook": facebook,
      };
}
