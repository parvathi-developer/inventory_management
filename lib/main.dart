import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/screens/home_screen.dart';
import 'package:inventory_management/screens/input_screen.dart';

void main() {
  runApp(InventoryManagementApp());
}

class InventoryManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Inventory Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
