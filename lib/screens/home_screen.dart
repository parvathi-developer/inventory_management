// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/constants/CustomDialog.dart';
import 'package:inventory_management/controller/inventory_controller.dart';
import 'package:inventory_management/models/stock_models.dart';
import 'package:inventory_management/screens/return_display_screen.dart';
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
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[100], // Set a light background color
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            // Allow scrolling if content overflows
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 4.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ElevatedButton.icon(
                          onPressed: showAddOpeningStockDialog,
                          icon: Icon(Icons.add),
                          label: Text('Add Opening Stock'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: showAddSalesInvoiceDialog,
                          icon: Icon(Icons.attach_money),
                          label: Text('Add Sales Invoice'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: showAddSalesReturnDialog,
                          icon: Icon(Icons.undo),
                          label: Text('Add Sales Return'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Obx(() => Text(
                      'Opening Stock Count: ${controller.openingStock.length}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                Obx(() => Text(
                      'Sales Invoice Count: ${controller.totalSalesCount}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                Obx(() => Text(
                      'Sales Return Count: ${controller.totalReturnCount}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => StockDisplayScreen(controller.openingStock));
                  },
                  child: Text('Show Ending Stock'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Get.to(
                        () => InvoiceScreen(invoices: controller.invoiceModel));
                  },
                  child: Text('Show Sales Stock'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
