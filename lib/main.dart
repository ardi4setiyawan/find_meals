import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(
    FindCategories(),
  );
}

class FindCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

