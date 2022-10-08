import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto01/pages/login.dart';
import 'package:proyecto01/services/loginService.dart';

class RememberUser extends StatefulWidget {
  const RememberUser({super.key});

  @override
  State<RememberUser> createState() => _RememberUserState();
}

class _RememberUserState extends State<RememberUser> {
  TextEditingController userController = TextEditingController();

  Future<void> validarDatos(String user, String password) async {
    final response = await LoginService().validar(user, password);

    if (response.statusCode == 200) {
      //almacenar de alguna manera el login

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
          "Remember password",
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
                    "Ingrese su usuario",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                sizedBox,
                Image.asset("assets/images/rememberForget.png"),
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
                            //validarDatos(
                            //    userController.text, passwordController.text);
                          }
                        },
                        child: Text("Recordar Password"))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
