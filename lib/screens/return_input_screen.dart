import 'package:flutter/material.dart';
import 'package:inventory_management/models/stock_models.dart';

class ReturnInputScreen extends StatefulWidget {
  final List<StockModel> salesInvoices;

  ReturnInputScreen(this.salesInvoices);

  @override
  _ReturnInputScreenState createState() => _ReturnInputScreenState();
}

class _ReturnInputScreenState extends State<ReturnInputScreen> {
  final TextEditingController itemCodeController = TextEditingController();
  final TextEditingController returnedQuantityController =
      TextEditingController();

  void createSalesReturns() {
    // Implement the logic to create sales returns based on the returned items
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Input Returned Items')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: itemCodeController,
              decoration: InputDecoration(labelText: 'Item Code'),
            ),
            TextField(
              controller: returnedQuantityController,
              decoration: InputDecoration(labelText: 'Returned Quantity'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: createSalesReturns,
              child: Text('Create Sales Return'),
            ),
          ],
        ),
      ),
    );
  }
}
