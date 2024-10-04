import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/screens/home_screen.dart';

void main() {
  runApp(InventoryManagementApp());
}

class InventoryManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // Disable debug banner

      title: 'Inventory Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
