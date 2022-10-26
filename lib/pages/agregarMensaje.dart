import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto01/pages/principal.dart';
import 'package:proyecto01/services/messageService.dart';

import '../global.dart';

class agregarMensaje extends StatefulWidget {
  const agregarMensaje({super.key});

  @override
  State<agregarMensaje> createState() => _agregarMensajeState();
}

class _agregarMensajeState extends State<agregarMensaje> {
  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();
  @override
  Future<void> validarMensaje(title, text) async {
    final response = await MessageService().validar(Global.login, title, text);

    if (response.statusCode == 200) {
      // await es necesario para esperar a que el usuario presione el boton y alcance a leer el mensaje
      await CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        title: 'Felicitaciones',
        text: 'Se ha registrado ingresado correctamente el mensaje!',
        loopAnimation: false,
      );
      // el usuario se registro correctamente
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

  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 30);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 127, 139, 1),
        centerTitle: true,
        title: Text(
          "Principal ${Global.login}",
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // SizedBox(
                //   width: 400,
                //   height: 200,
                //   child: Image.asset('assets/tocho.jpg', fit: BoxFit.fill),
                // ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Agregar nuevo mensaje",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                sizedBox,
                TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        hintText: "Ingrese un título",
                        labelText: "Título",
                        suffixIcon: const Icon(Icons.format_quote,
                            color: Colors.black54))),
                sizedBox,
                TextField(
                    controller: textController,
                    minLines: 3,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Ingrese un mensaje",
                        labelText: "Descripción",
                        suffixIcon: const Icon(Icons.forum))),
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
                          if (titleController.text.length == 0) {
                            Fluttertoast.showToast(
                                msg: "Ingrese un título",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (textController.text.length == 0) {
                            Fluttertoast.showToast(
                                msg: "Ingrese un mensaje",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            validarMensaje(
                                titleController.text, textController.text);
                          }
                        },
                        child: const Text("Enviar"))),
                sizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
