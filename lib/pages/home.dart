// ignore_for_file: prefer_const_declarations, prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, unused_local_variable

import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import '../widgets/mycontainer.dart';
import 'notes.dart';
import 'checkattendance.dart'; // Import your CheckAttendance class

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int days = 69;
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance System"),
      ),
      body: Column(
        children: [
          MyContainer(),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Navigate to the CheckAttendance page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckAttendance()),
              );
            },
            child: Text("Check Attendance"),
          ),
          SizedBox(height: 16.0),
          GestureDetector(
            onTap: () {
              // Navigate to the Notes page (ClassroomScreen)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClassroomScreen()),
              );
            },
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                "Notes",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}

// Your MyContainer and MyDrawer classes go here

class ClassroomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Classroom"),
      ),
      body: Center(
        child: Text("Classroom Screen"),
      ),
    );
  }
}