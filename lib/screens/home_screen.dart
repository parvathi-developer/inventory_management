// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/constants/CustomDialog.dart';
import 'package:inventory_management/controller/inventory_controller.dart';
import 'package:inventory_management/models/stock_models.dart';
import 'package:inventory_management/screens/stock_display_screen.dart';

class HomeScreen extends StatelessWidget {
  final InventoryController controller = Get.put(InventoryController());

  void showAddOpeningStockDialog() {
    final TextEditingController codeController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController unitController = TextEditingController();

    Get.dialog(
      CustomDialog(
        title: 'Add Opening Stock',
        controllers: [codeController, quantityController, unitController],
        labels: ['Item Code', 'Quantity', 'Unit'],
        inputDecorations: [
          InputDecoration(hintText: 'Enter item code'),
          InputDecoration(hintText: 'Enter quantity'),
          InputDecoration(hintText: 'Enter unit'),
        ],
        keyboardTypes: [
          TextInputType.text,
          TextInputType.number,
          TextInputType.text,
        ],
        items: <StockModel>[].obs, // No items needed here
        isSalesInvoice: false,
      ),
    );
  }

  void showAddSalesInvoiceDialog() {
    final TextEditingController customerController = TextEditingController();
    final RxList<StockModel> items = <StockModel>[].obs;

    Get.dialog(
      CustomDialog(
        title: 'Add Sales Invoice',
        controllers: [customerController],
        labels: ['Customer Name'],
        inputDecorations: [
          InputDecoration(hintText: 'Enter customer name'),
        ],
        keyboardTypes: [
          TextInputType.text,
        ],
        items: items,
        isSalesInvoice: true,
      ),
    );
  }

  void showAddSalesReturnDialog() {
    final TextEditingController customerController = TextEditingController();
    final RxList<StockModel> items = <StockModel>[].obs;

    Get.dialog(
      CustomDialog(
        title: 'Add Sales Return',
        controllers: [customerController],
        labels: ['Customer Name'],
        inputDecorations: [
          InputDecoration(hintText: 'Enter customer name'),
        ],
        keyboardTypes: [
          TextInputType.text,
        ],
        items: items,
        isSalesInvoice: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Management'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: showAddOpeningStockDialog,
              child: Text('Add Opening Stock'),
            ),
            ElevatedButton(
              onPressed: showAddSalesInvoiceDialog,
              child: Text('Add Sales Invoice'),
            ),
            ElevatedButton(
              onPressed: showAddSalesReturnDialog,
              child: Text('Add Sales Return'),
            ),
            SizedBox(height: 20),
            Obx(() =>
                Text('Opening Stock Count: ${controller.openingStock.length}')),
            Obx(() =>
                Text('Sales Invoice Count: ${controller.totalSalesCount}')),
            Obx(() =>
                Text('Sales Return Count: ${controller.totalReturnCount}')),
            ElevatedButton(
              onPressed: () {
                Get.to(() => StockDisplayScreen(
                      controller.openingStock,
                    ));
              },
              child: Text('Show Ending Stock'),
            ),
          ],
        ),
      ),
    );
  }
}
