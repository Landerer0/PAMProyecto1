// To parse this JSON data, do
//
//     final messageDto = messageDtoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<MessageDto> messageDtoFromJson(String str) =>
    List<MessageDto>.from(json.decode(str).map((x) => MessageDto.fromJson(x)));

String messageDtoToJson(MessageDto data) => json.encode(data.toJson());

class MessageDto {
  MessageDto({
    required this.fecha,
    required this.id,
    required this.login,
    required this.texto,
    required this.titulo,
  });

  DateTime fecha;
  int id;
  String login;
  String texto;
  String titulo;

  factory MessageDto.fromJson(Map<String, dynamic> json) => MessageDto(
        fecha: DateTime.parse(json["fecha"]),
        id: json["id"],
        login: json["login"],
        texto: json["texto"],
        titulo: json["titulo"],
      );

  Map<String, dynamic> toJson() => {
        "fecha": fecha.toIso8601String(),
        "id": id,
        "login": login,
        "texto": texto,
        "titulo": titulo,
      };
}
