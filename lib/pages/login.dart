import 'package:cool_alert/cool_alert.dart';
import 'package:proyecto01/global.dart';
import 'package:proyecto01/pages/principal.dart';
import 'package:proyecto01/pages/rememberUser.dart';
import 'package:proyecto01/pages/signup.dart';
import 'package:proyecto01/services/loginService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  late final pref;

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> validarDatos(String user, String password) async {
    final response = await LoginService().validar(user, password);

    if (response.statusCode == 200) {
      //almacenar de alguna manera el login

      await pref.setString('usuario', user);

      Global.login = user;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Principal()));
    } else {
      CoolAlert.show(
        backgroundColor: Global.colorSupport,
        confirmBtnColor: Global.colorSecundario,
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text:
            "Error API", //'Ha ocurrido un error, vuelve a intentarlo más tarde',
        loopAnimation: false,
      );
    }
  }

  String? login_guardado = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargaPreferencia();
  }

  void cargaPreferencia() async {
    pref = await SharedPreferences.getInstance();
    login_guardado = pref.getString("usuario");
    userController.text = login_guardado == null ? "" : login_guardado!;
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 30);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Global.colorOficial,
        title: const Text("Ingreso"),
        centerTitle: true,
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
                    "Ingresa tus credenciales",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Global.colorSecundario),
                  ),
                ),
                Image.asset("assets/images/login.jpg"),
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
                TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        hintText: "Ingrese su contraseña",
                        labelText: "Contraseña",
                        suffixIcon: const Icon(Icons.remove_red_eye))),
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
                          } else if (passwordController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Ingrese una contraseña",
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
                        child: const Text("Acceder"))),
                sizedBox,
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RememberUser()));
                    },
                    child: Text(
                      "¿Olvidó su contraseña?",
                      style: TextStyle(
                          color: Global.colorTexto,
                          fontWeight: FontWeight.bold),
                    )),
                sizedBox,
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
                    },
                    child: Text(
                      "Regístrese aquí",
                      style: TextStyle(
                          color: Global.colorTexto,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
