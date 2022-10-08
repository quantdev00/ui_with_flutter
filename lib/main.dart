import 'package:auth_phone/to_do/main_app.dart';
import 'package:auth_phone/views/main_ui_practicing.dart';
import 'package:auth_phone/views/simple_calculator/calculator_ui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorUi(),
    );
  }
}
