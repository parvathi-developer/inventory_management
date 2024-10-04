import 'package:flutter/material.dart';
import 'package:inventory_management/models/invoice_models.dart';
import 'package:inventory_management/models/stock_models.dart';

class InvoiceScreen extends StatelessWidget {
  final List<Invoice> invoices;

  InvoiceScreen({Key? key, required this.invoices}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sales Invoices',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal, // Customize AppBar color
      ),
      body: Container(
        color: Colors.grey[100], // Set a light background color
        padding: const EdgeInsets.all(16.0),
        child: invoices.isEmpty // Check if there are no invoices
            ? Center(
                child: Text(
                  'No invoices available',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildInvoiceTables(),
                ),
              ),
      ),
    );
  }

  List<Widget> _buildInvoiceTables() {
    List<Widget> tables = [];

    for (var i = 0; i < invoices.length; i++) {
      var invoice = invoices[i];

      // Filter items to include only those with a return quantity greater than 0
      final filteredItems =
          invoice.items.where((item) => item.returnQuantity > 0).toList();

      if (filteredItems.isNotEmpty)
        tables.add(
          Card(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            elevation: 6, // Increase elevation for a more pronounced shadow
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            child: Padding(
              padding: const EdgeInsets.all(
                  16.0), // Increased padding for better spacing
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Customer: ${invoice.customer}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Type: Sales Invoice',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 10),
                  _buildItemTable(filteredItems),
                  Divider(
                      color: Colors
                          .tealAccent), // Colored divider for better separation
                ],
              ),
            ),
          ),
        );
    }

    return tables;
  }

  Widget _buildItemTable(List<StockModel> items) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20, // Increased spacing between columns
        headingTextStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        dataTextStyle: TextStyle(color: Colors.black),
        headingRowColor: MaterialStateProperty.all(
            Colors.teal), // Custom heading background color
        columns: const [
          DataColumn(label: Text('Item Code')),
          DataColumn(label: Text('Quantity')),
          DataColumn(label: Text('Unit of Measure')),
        ],
        rows: items.map((item) {
          return DataRow(cells: [
            DataCell(Text(item.code)),
            DataCell(Text(item.returnQuantity.toString())),
            DataCell(Text(item.unit)),
          ]);
        }).toList(),
      ),
    );
  }
}
