import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proyecto01/global.dart';

class LoginService {
  // Validar que los datos ingresados del usuario pertenecen al sistema
  Future<http.Response> validar(String login, String pass) async {
    return await http.post(
      Uri.parse(Global.baseApiUrl + '/api/Usuarios'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'login': login, 'pass': pass}),
    );
  }

  // Registrar un usuario en el sistema
  Future<http.Response> registroUsuario(String login, String pass) async {
    return await http.post(
      Uri.parse(
          Global.baseApiUrl + '/api/Usuarios?login=' + login + '&pass=' + pass),
    );
  }

  // Indicar la password de un usuario dado el nombre de usuario
  Future<http.Response> recordarPass(String login) async {
    return await http.get(Uri.parse(Global.baseApiUrl + '/api/Usuarios'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
  }
}
