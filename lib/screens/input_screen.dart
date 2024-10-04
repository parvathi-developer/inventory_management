import 'package:flutter/material.dart';
import 'package:inventory_management/models/invoice_models.dart';
import 'package:inventory_management/models/stock_models.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final List<StockModel> openingStock = [];
  final List<Invoice> salesInvoices = [];
  final TextEditingController itemCodeController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController customerController = TextEditingController();
  final List<Invoice> salesReturns = [];

  void addOpeningStock() {
    final itemCode = itemCodeController.text;
    final quantity = int.tryParse(quantityController.text) ?? 0;
    final unit = unitController.text;

    if (itemCode.isNotEmpty && quantity > 0 && unit.isNotEmpty) {
      setState(() {
        openingStock.add(StockModel(
          code: itemCode,
          initialQuantity: quantity,
          unit: unit,
        ));
      });
      itemCodeController.clear();
      quantityController.clear();
      unitController.clear();
    }
  }

  void addSalesInvoice() {
    final customer = customerController.text;
    // You can implement invoice logic similarly

    if (customer.isNotEmpty) {
      // Add invoices to the salesInvoices list
      // Add UI to input invoice items
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Input Stock & Invoices')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Opening Stock', style: TextStyle(fontSize: 20)),
            TextField(
              controller: itemCodeController,
              decoration: InputDecoration(labelText: 'Item Code'),
            ),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: unitController,
              decoration: InputDecoration(labelText: 'Unit of Measure'),
            ),
            ElevatedButton(
              onPressed: addOpeningStock,
              child: Text('Add Opening Stock'),
            ),
            Text('Sales Invoices', style: TextStyle(fontSize: 20)),
            TextField(
              controller: customerController,
              decoration: InputDecoration(labelText: 'Customer Name'),
            ),
            ElevatedButton(
              onPressed: addSalesInvoice,
              child: Text('Add Sales Invoice'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the stock display screen to calculate and show final stock
              },
              child: Text('Calculate Ending Stock'),
            ),
          ],
        ),
      ),
    );
  }
}
