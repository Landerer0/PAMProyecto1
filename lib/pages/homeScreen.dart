import 'package:flutter/material.dart';
import 'package:proyecto01/pages/login.dart';
import 'package:proyecto01/pages/signup.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const sizedBox = const SizedBox(height: 30);
    return Scaffold(
      backgroundColor: Color.fromRGBO(62, 127, 139, 1),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                sizedBox,
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Bienvenido",
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        color: Color.fromARGB(255, 26, 60, 66)),
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
                            primary: Colors.indigo, shape: StadiumBorder()),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => login()));
                        },
                        child: Text("Login"))),
                sizedBox,
                sizedBox,
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigo, shape: StadiumBorder()),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text("Registrarme"))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
