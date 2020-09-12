
import 'package:degigban/user/bienvenue.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(71, 147, 12, 1),
            accentColor: Color.fromRGBO(71, 147, 12, 1),
      ),
      title: 'Degnigban',
      home: Bienvenue(),
      debugShowCheckedModeBanner: false,
    );
  }
}
