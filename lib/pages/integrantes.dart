import 'package:flutter/material.dart';

import '../global.dart';

class Integrantes extends StatefulWidget {
  const Integrantes({super.key});

  @override
  State<Integrantes> createState() => _IntegrantesState();
}

class _IntegrantesState extends State<Integrantes> {
  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 20);
    return Scaffold(
      //const sizedBox = SizedBox(height: 20);
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 127, 139, 1),
        centerTitle: true,
        title: Text(
          "Principal ${Global.login}",
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(2),
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ListTile(
                      //leading: Icon(Icons.album),
                      title: Text("Integrantes",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      //subtitle: Text("Por: ${obj.login}"),
                    ),
                    FractionallySizedBox(
                      //para que el texto abarque un porcentaje del cuadro completo
                      widthFactor: 0.95,
                      child: Column(
                        children: const [
                          Text(
                            "Lucas Kraemer Ananías",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Cristián Pérez Vásquez",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    sizedBox,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
