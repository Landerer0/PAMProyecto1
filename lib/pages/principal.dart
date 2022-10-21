import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

import '../global.dart';

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Principal ${Global.login}"),
        ),
        //drawer: SidebarCustom(),
        body: Center(
          child: Text("ඞඞඞඞඞඞඞ login success"),
        ));
  }

  /*
  Widget SidebarCustom() {
    return SidebarX(
        controller: SidebarXController(selectedIndex: 0),
        items: const [
          SidebarXItem(icon: Icons.home, label: 'Home'),
          SidebarXItem(icon: Icons.search, label: 'Search'),
        ]);
  }
  */
}
