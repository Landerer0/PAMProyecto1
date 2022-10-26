import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:proyecto01/pages/agregarMensaje.dart';
import 'package:proyecto01/pages/homeScreen.dart';
import 'package:proyecto01/dto/messageDTO.dart';
import 'package:sidebarx/sidebarx.dart';

import 'package:http/http.dart' as http;

import '../global.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  late Future<List<MessageDto>> futureMessages;
  late List items;

  @override
  void initState() {
    super.initState();
    futureMessages = getMessages();
  }

  Future<List<MessageDto>> getMessages() async {
    final response =
        await http.get(Uri.parse(Global.baseApiUrl + '/api/mensajes'));

    if (response.statusCode == 200) {
      //print(response.body);
      return messageDtoFromJson(response.body);
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: 'Ha ocurrido un error, vuelve a intentarlo más tarde',
        loopAnimation: false,
      );
      throw Exception('Error GET api mensajes');
    }
  }

  Future<void> validarMensajes() async {
    // buscar el nombre del usuario
    // print("Se esta Validando los datos");
    items = await futureMessages;
    return;
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Principal ${Global.login}"),
        ),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text("Hola!"),
            ),
            ListTile(
              title: const Text("Agregar"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const agregarMensaje()));
              },
            ),
            ListTile(
              title: const Text("Integrantes"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Salir"),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen())),
            )
          ],
        )),
        body: SingleChildScrollView(
          child: FutureBuilder<List<MessageDto>>(
              future: futureMessages,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    List<Widget> listaMensajes = [];
                    for (var mensaje in snapshot.data!) {
                      listaMensajes.add(tarjeta(mensaje));
                    }
                    return Column(
                      children: listaMensajes,
                    );
                  }
                } else if (snapshot.hasError) {
                  return const Text("Error al cargar los mensajes!");
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }

  Widget tarjeta(MessageDto obj) {
    const sizedBox = SizedBox(height: 20);
    return SingleChildScrollView(
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
                  ListTile(
                    //leading: Icon(Icons.album),
                    title: Text("${obj.titulo}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text("Por: ${obj.login}"),
                  ),
                  FractionallySizedBox(
                    //para que el texto abarque un porcentaje del cuadro completo
                    widthFactor: 0.95,
                    child: Text(
                      obj.texto,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  sizedBox,
                  Text(
                    "Fecha: ${obj.fecha}",
                    style: const TextStyle(
                        fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
