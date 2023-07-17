// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, prefer_const_declarations, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final imageURL = "https://media.licdn.com/dms/image/D4D03AQFgU_409LQdwA/profile-displayphoto-shrink_800_800/0/1664428643798?e=1694649600&v=beta&t=8GRP7TVCrnt2kwVYaGh6l4IzmS_90cf8jACzbP_y_60";

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              accountName:  Text("Shubham Yadav"),
               accountEmail: Text("Shubhamyadavs18508@gmail.com"),
               currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(imageURL),
               ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.home ,
                  color:Colors.deepPurple,
                  size: 30,
                ),
                title: Text(
                  "Home",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  ),
              ),
            ),
        ],
      ),
    );
  }
}