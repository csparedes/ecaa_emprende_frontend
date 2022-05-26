// To parse this JSON data, do
//
//     final estudianteModel = estudianteModelFromJson(jsonString);

import 'dart:convert';

EstudianteModel estudianteModelFromJson(String str) =>
    EstudianteModel.fromJson(json.decode(str));

String estudianteModelToJson(EstudianteModel data) =>
    json.encode(data.toJson());

class EstudianteModel {
  EstudianteModel({
    required this.cedula,
    required this.apellidos,
    required this.nombres,
    required this.carrera,
    required this.email,
    required this.registro,
  });

  String cedula;
  String apellidos;
  String nombres;
  String carrera;
  String email;
  String registro;

  factory EstudianteModel.fromJson(Map<String, dynamic> json) =>
      EstudianteModel(
        cedula: json["cedula"],
        apellidos: json["apellidos"],
        nombres: json["nombres"],
        carrera: json["carrera"],
        email: json["email"],
        registro: json["registro"],
      );

  Map<String, dynamic> toJson() => {
        "cedula": cedula,
        "apellidos": apellidos,
        "nombres": nombres,
        "carrera": carrera,
        "email": email,
        "registro": registro,
      };
}
