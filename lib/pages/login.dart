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
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: 'Ha ocurrido un error, vuelve a intentarlo más tarde',
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
    const sizedBox = const SizedBox(height: 30);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(62, 127, 139, 1),
        title: Text("Login"),
        centerTitle: true,
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
                    "Ingrese sus datos",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
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
                        labelText: "password",
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
                                msg: "Ingrese un usuario valido",
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
                        child: Text("Acceder"))),
                sizedBox,
                GestureDetector(
                    /*onLongPress: () {
                      //
                    },*/
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RememberUser()));
                    },
                    child: Text(
                      "¿Olvido su password?",
                      style: TextStyle(color: Colors.blue),
                    )),
                sizedBox,
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      "Registrese Aquí",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
