// To parse this JSON data, do
//
//     final transporteModel = transporteModelFromJson(jsonString);

import 'dart:convert';

TransporteModel transporteModelFromJson(String str) =>
    TransporteModel.fromJson(json.decode(str));

String transporteModelToJson(TransporteModel data) =>
    json.encode(data.toJson());

class TransporteModel {
  TransporteModel({
    this.id,
    this.nombre,
    this.descripcion,
    this.ubicacion,
    this.imagenes,
    this.coordenadas,
    this.horario,
    this.rutas,
    this.telefono,
    this.correo,
    this.facebook,
  });

  String id;
  String nombre;
  String descripcion;
  String ubicacion;
  String imagenes;
  String coordenadas;
  String horario;
  String rutas;
  String telefono;
  String correo;
  String facebook;

  factory TransporteModel.fromJson(Map<String, dynamic> json) =>
      TransporteModel(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        ubicacion: json["ubicacion"],
        imagenes: json["imagenes"],
        coordenadas: json["coordenadas"],
        horario: json["horario"],
        rutas: json["rutas"],
        telefono: json["telefono"],
        correo: json["correo"],
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
        "rutas": rutas,
        "telefono": telefono,
        "correo": correo,
        "facebook": facebook,
      };
}
