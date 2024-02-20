import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/loginpage.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/utils/routes.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
  
    return  MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      // initialRoute: "/home",
      debugShowCheckedModeBanner: false,
      routes:{
        "/":(context) => LoginPage(),
        MyRoutes.HomeRoute:(context) => HomePage(),
        MyRoutes.LoginRoute: (context) => LoginPage(),
        
      }
    );
  }
}
