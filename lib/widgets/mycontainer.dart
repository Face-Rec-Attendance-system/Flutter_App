// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'form.dart';

class MyContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to a different route
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecondScreen()),
        );
      },
      child: Container(
        width: double.infinity,
        height: 200,
        // color: Colors.blue,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Take.png'),
            fit: BoxFit.cover,
            ),
        ),
          child: Text(
            '',
            style: TextStyle(color: Colors.blue[300],fontSize: 40),
          ),
        
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        // child: Text('You have navigated to the second screen!'),
        child: MyFormPage(),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Container Tap Example'),
      ),
      body: MyContainer(),
    ),
  ));
}
