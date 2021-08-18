// To parse this JSON data, do
//
//     final usuariosModel = usuariosModelFromJson(jsonString);

import 'dart:convert';

UsuariosModel usuariosModelFromJson(String str) =>
    UsuariosModel.fromJson(json.decode(str));

String usuariosModelToJson(UsuariosModel data) => json.encode(data.toJson());

class UsuariosModel {
  UsuariosModel({
    this.id,
    this.nombre,
    this.apellido,
    this.email,
    this.edad,
    this.ciudad,
    this.pais,
    this.sitioPreferido,
  });

  String id;
  String nombre;
  String apellido;
  String email;
  String edad;
  String ciudad;
  String pais;
  String sitioPreferido;

  factory UsuariosModel.fromJson(Map<String, dynamic> json) => UsuariosModel(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        email: json["email"],
        edad: json["edad"],
        ciudad: json["ciudad"],
        pais: json["pais"],
        sitioPreferido: json["sitio_preferido"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "email": email,
        "edad": edad,
        "ciudad": ciudad,
        "pais": pais,
        "sitio_preferido": sitioPreferido,
      };
}
