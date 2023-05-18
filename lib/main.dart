import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),      debugShowCheckedModeBanner: false,

      home: const Home(),
    );
  }
}


