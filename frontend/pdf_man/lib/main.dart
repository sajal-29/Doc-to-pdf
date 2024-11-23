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
      home: DocxToPdfConverter(),
    );
  }
}

