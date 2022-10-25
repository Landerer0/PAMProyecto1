import 'package:flutter/material.dart';
import 'package:proyecto01/pages/login.dart';
import 'package:proyecto01/pages/signup.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 30);
    return Scaffold(
      //backgroundColor: Color.fromRGBO(62, 127, 139, 1),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blueGrey, Colors.cyan],
        )),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                sizedBox,
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "¡Bienvenido!",
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        color: Color.fromRGBO(31, 64, 80, 1)),
                  ),
                ),
                sizedBox,
                Image.asset("assets/images/hall.png"),
                sizedBox,
                sizedBox,
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigo,
                            shape: const StadiumBorder()),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const login()));
                        },
                        child: const Text("Login"))),
                sizedBox,
                sizedBox,
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigo,
                            shape: const StadiumBorder()),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        },
                        child: const Text("Registrarme"))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
