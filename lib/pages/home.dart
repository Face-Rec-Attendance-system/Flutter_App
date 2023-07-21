// ignore_for_file: prefer_const_declarations, prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import '../widgets/mycontainer.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final int days = 69;
    return Scaffold(
        appBar: AppBar(
          title: Text("Attendance System"),
        ),
        body: Container(
          child: MyContainer()),
        drawer: MyDrawer(),
      );
  }
}

