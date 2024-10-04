// lib/widgets/custom_dialog.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/controller/inventory_controller.dart';
import 'package:inventory_management/models/stock_models.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final List<TextEditingController> controllers;
  final List<String> labels;
  final List<InputDecoration> inputDecorations;
  final List<TextInputType> keyboardTypes;
  final RxList<StockModel> items;
  final bool isSalesInvoice;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.controllers,
    required this.labels,
    required this.inputDecorations,
    required this.keyboardTypes,
    required this.items,
    required this.isSalesInvoice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InventoryController controller = Get.put(InventoryController());

    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < controllers.length; i++)
              TextField(
                controller: controllers[i],
                decoration: inputDecorations[i].copyWith(labelText: labels[i]),
                keyboardType: keyboardTypes[i],
              ),
            if (isSalesInvoice || title.contains("Return"))
              ElevatedButton(
                onPressed: () {
                  // Add logic to show item selection dialog
                  showAddItemDialog(items, isSalesInvoice);
                },
                child: Text('Add Item'),
              ),
            if (isSalesInvoice || title.contains("Return"))
              Obx(() => Column(
                    children: items
                        .map((item) => Text(
                            '${item.code}: ${isSalesInvoice ? item.salesQuantity : item.returnQuantity} ${item.unit}'))
                        .toList(),
                  )),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (controllers.every((controller) => controller.text.isNotEmpty)) {
              if (isSalesInvoice || title.contains("Return")) {
                if (isSalesInvoice) {
                  controller.addSalesInvoice(
                    controllers[0].text,
                    items,
                  );
                } else {
                  controller.addSalesReturn(
                    controllers[0].text,
                    items,
                  );
                }
              } else {
                controller.addOpeningStock(
                  controllers[0].text,
                  int.parse(controllers[1].text),
                  controllers[2].text,
                );
                Get.back();
              }
              // Handle save logic here

              Get.back();
            } else {
              Get.snackbar("Error", "Please fill all fields",
                  snackPosition: SnackPosition.BOTTOM);
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  void showAddItemDialog(RxList<StockModel> items, bool fromSales) {
    final TextEditingController codeController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController unitController = TextEditingController();

    Get.defaultDialog(
      title: 'Add Item to Invoice',
      content: Column(
        children: [
          TextField(
            controller: codeController,
            decoration: InputDecoration(labelText: 'Item Code'),
          ),
          TextField(
            controller: quantityController,
            decoration: InputDecoration(labelText: 'Quantity'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: unitController,
            decoration: InputDecoration(labelText: 'Unit Code'),
          ),
        ],
      ),
      confirm: ElevatedButton(
        onPressed: () {
          if (codeController.text.isNotEmpty &&
              quantityController.text.isNotEmpty &&
              unitController.text.isNotEmpty) {
            items.add(StockModel(
              code: codeController.text,
              salesQuantity: fromSales ? int.parse(quantityController.text) : 0,
              returnQuantity:
                  fromSales ? 0 : int.parse(quantityController.text),
              initialQuantity: 0,
              unit: unitController.text, // Modify as needed
            ));
            Get.back();
          } else {
            Get.snackbar("Error", "Please fill all fields",
                snackPosition: SnackPosition.BOTTOM);
          }
        },
        child: Text('Add Item'),
      ),
      cancel: ElevatedButton(
        onPressed: () => Get.back(),
        child: Text('Cancel'),
      ),
    );
  }
}
