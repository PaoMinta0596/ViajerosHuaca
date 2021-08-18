// To parse this JSON data, do
//
//     final gastronomiaModel = gastronomiaModelFromJson(jsonString);

import 'dart:convert';

GastronomiaModel gastronomiaModelFromJson(String str) =>
    GastronomiaModel.fromJson(json.decode(str));

String gastronomiaModelToJson(GastronomiaModel data) =>
    json.encode(data.toJson());

class GastronomiaModel {
  GastronomiaModel({
    this.id,
    this.nombre,
    this.descripcion,
    this.costo,
    this.imagenes,
  });

  String id;
  String nombre;
  String descripcion;
  String costo;
  String imagenes;

  factory GastronomiaModel.fromJson(Map<String, dynamic> json) =>
      GastronomiaModel(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        costo: json["costo"],
        imagenes: json["imagenes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "costo": costo,
        "imagenes": imagenes,
      };
}
