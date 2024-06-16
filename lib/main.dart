import 'package:flutter/material.dart';
import 'views/main_screen.dart';

void main() {
  runApp(BakeryWarehouseApp());
}

class BakeryWarehouseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bakery Warehouse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}
