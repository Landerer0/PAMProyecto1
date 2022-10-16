import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto01/pages/login.dart';
import 'package:proyecto01/services/loginService.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  Future<void> validarDatos(String user, String password) async {
    final response = await LoginService().registroUsuario(user, password);

    if (response.statusCode == 200) {
      // await es necesario para esperar a que el usuario presione el boton y alcance a leer el mensaje
      await CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        title: 'Felicitaciones',
        text: 'Se ha registrado correctamente el usuario "' + user + '"',
        loopAnimation: false,
      );
      // el usuario se registro correctamente
      Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: 'Ha ocurrido un error, vuelve a intentarlo más tarde',
        loopAnimation: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = const SizedBox(height: 30);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(62, 127, 139, 1),
        centerTitle: true,
        title: Text(
          "Sign Up",
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // SizedBox(
                //   width: 400,
                //   height: 200,
                //   child: Image.asset('assets/tocho.jpg', fit: BoxFit.fill),
                // ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Registro",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                sizedBox,
                Image.asset("assets/images/openbook.png"),
                sizedBox,
                TextField(
                    controller: userController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        hintText: "Ingrese su usuario",
                        labelText: "User",
                        suffixIcon:
                            const Icon(Icons.email, color: Colors.black54))),
                sizedBox,
                TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        hintText: "Ingrese su password",
                        labelText: "Password",
                        suffixIcon: const Icon(Icons.remove_red_eye))),
                sizedBox,
                TextField(
                    controller: repeatPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        hintText: "Repita su password",
                        labelText: "Repetir password",
                        suffixIcon: const Icon(Icons.remove_red_eye))),
                sizedBox,
                sizedBox,
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigo, shape: StadiumBorder()),
                        onPressed: () {
                          if (userController.text.length == 0) {
                            Fluttertoast.showToast(
                                msg: "Ingrese un usuario",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (passwordController.text.length == 0 ||
                              repeatPasswordController.text.length == 0) {
                            Fluttertoast.showToast(
                                msg: "Ingrese la contraseña y su repetición",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (passwordController.text !=
                              repeatPasswordController.text) {
                            Fluttertoast.showToast(
                                msg: "Las contraseñas ingresadas no coinciden",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            validarDatos(
                                userController.text, passwordController.text);
                          }
                        },
                        child: Text("Registrarme"))),
                sizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
