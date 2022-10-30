import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto01/dto/userDTO.dart';
import 'package:proyecto01/global.dart';
import 'package:proyecto01/pages/login.dart';

import 'package:http/http.dart' as http;

class RememberUser extends StatefulWidget {
  const RememberUser({super.key});

  @override
  State<RememberUser> createState() => _RememberUserState();
}

class _RememberUserState extends State<RememberUser> {
  late Future<List<UserDto>> futureUser;
  TextEditingController userController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureUser = getUsers();
  }

  Future<List<UserDto>> getUsers() async {
    final response =
        await http.get(Uri.parse(Global.baseApiUrl + '/api/usuarios'));

    if (response.statusCode == 200) {
      //print(response.body);

      return userDtoFromJson(response.body);
    } else {
      CoolAlert.show(
        backgroundColor: Global.colorSupport,
        confirmBtnColor: Global.colorSecundario,
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: 'Ha ocurrido un error, vuelve a intentarlo más tarde',
        loopAnimation: false,
      );
      throw Exception('Error GET api usuarios');
    }
  }

  Future<void> validarDatos(String user) async {
    List listaUser = await futureUser;
    for (var userLista in listaUser) {
      if (userLista.login == user) {
        await CoolAlert.show(
          backgroundColor: Global.colorSupport,
          confirmBtnColor: Global.colorSecundario,
          context: context,
          type: CoolAlertType.success,
          title: 'La password de $user es:',
          text: '"' + userLista.pass + '"',
          loopAnimation: false,
        );

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => login()));

        return;
      }
    }
    Fluttertoast.showToast(
        msg: "El usuario ingresado no existe",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 30);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Global.colorOficial,
        centerTitle: true,
        title: const Text(
          "¿Olvidó su contraseña?",
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Ingrese su usuario",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Global.colorSecundario),
                  ),
                ),
                sizedBox,
                Image.asset("assets/images/personLock.png"),
                sizedBox,
                TextField(
                    controller: userController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        hintText: "Ingrese su usuario",
                        labelText: "Usuario",
                        suffixIcon:
                            const Icon(Icons.email, color: Colors.black54))),
                sizedBox,
                sizedBox,
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Global.colorSecundario,
                            shape: const StadiumBorder()),
                        onPressed: () {
                          if (userController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Ingrese un usuario válido",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            validarDatos(userController.text);
                          }
                        },
                        child: const Text("Recordar contraseña"))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
