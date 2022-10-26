import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proyecto01/global.dart';

class MessageService {
  // Validar que los datos ingresados del usuario pertenecen al sistema
  Future<http.Response> validar(
      String login, String titulo, String desc) async {
    return await http.post(
      Uri.parse(Global.baseApiUrl + '/api/mensajes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'login': login, 'titulo': titulo, 'texto': desc}),
    );
  }

  // Agregar un mensaje en el sistema
  Future<http.Response> ingresoMensaje(
      String login, String titulo, String descripcion) async {
    return await http.post(
      Uri.parse(Global.baseApiUrl +
          '/api/mensajes?login=' +
          login +
          '&titulo=' +
          titulo +
          '&texto=' +
          descripcion),
    );
  }
}
