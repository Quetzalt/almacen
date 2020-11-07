import 'package:almacen/src/pages/RegistroInventario.dart';
import 'package:flutter/material.dart';
import 'package:almacen/src/pages/homePage.dart';
import 'package:almacen/src/pages/menuInventario.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Almacen',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'menuInventario': (BuildContext context) => MenuInventario(),
        'registro': (BuildContext content) => RegistroProducto()
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
      ),
    );
  }
}
