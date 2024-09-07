import 'package:app1/Auth/login.dart';
import 'package:app1/Auth/menuA.dart';
import 'package:app1/Auth/type_actor.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(), // Initial route
      routes: {
        '/login': (context) => Login(), // Define Login widget
        '/type_actor': (context) => const TypeActor(),
        '/menuA': (context) => Menua(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
