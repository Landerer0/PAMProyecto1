// clase generada en https://app.quicktype.io usando el JSON proporcionado por un get de
// https://b07641d697eb.sa.ngrok.io/api/usuarios
// usando el campo required y posteriormente eliminando los @ de @required

// To parse this JSON data, do
//
//     final userDto = userDtoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<UserDto> userDtoFromJson(String str) =>
    List<UserDto>.from(json.decode(str).map((x) => UserDto.fromJson(x)));

String userDtoToJson(List<UserDto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDto {
  UserDto({
    required this.id,
    required this.login,
    required this.pass,
    required this.nombre,
    required this.ultimaFechaIngreso,
  });

  int id;
  String login;
  String pass;
  String nombre;
  dynamic ultimaFechaIngreso;

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        id: json["Id"],
        login: json["login"],
        pass: json["pass"],
        nombre: json["nombre"],
        ultimaFechaIngreso: json["UltimaFechaIngreso"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "login": login,
        "pass": pass,
        "nombre": nombre,
        "UltimaFechaIngreso": ultimaFechaIngreso,
      };
}
