import 'package:flutter/material.dart';

import '../global.dart';

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Principal ${Global.login}"),
        ),
        body: Center(
          child: Text("ඞඞඞඞඞඞඞ login success"),
        ));
  }
}
