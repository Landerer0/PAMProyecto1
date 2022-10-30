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
    final response =
        await MessageService().ingresoMensaje(Global.login, title, text);

    if (response.statusCode == 201) {
      // await es necesario para esperar a que el usuario presione el boton y alcance a leer el mensaje
      await CoolAlert.show(
        backgroundColor: Global.colorSupport,
        confirmBtnColor: Global.colorSecundario,
        context: context,
        type: CoolAlertType.success,
        title: 'Felicitaciones',
        text: '¡Se ha registrado ingresado correctamente el mensaje!',
        loopAnimation: false,
      );
      // el usuario se registro correctamente
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Principal()));
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
    }
  }

  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 30);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Global.colorOficial,
        centerTitle: true,
        title: Text(
          "¡Bienvenido ${Global.login}!",
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
                    "Agregar nuevo mensaje",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Global.colorSecundario),
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
                    minLines: 10,
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
                            backgroundColor: Global.colorSecundario,
                            shape: const StadiumBorder()),
                        onPressed: () {
                          if (titleController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Ingrese un título",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (textController.text.isEmpty) {
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
