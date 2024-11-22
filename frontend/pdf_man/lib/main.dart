import 'package:flutter/material.dart';
import './screen/DocxToPdfConverter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[900],
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
      ),
      home: DocxToPdfConverter(),
    );
  }
}

