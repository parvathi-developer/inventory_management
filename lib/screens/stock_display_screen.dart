import 'package:flutter/material.dart';
import 'package:inventory_management/models/invoice_models.dart';
import 'package:inventory_management/models/stock_models.dart';

class StockDisplayScreen extends StatelessWidget {
  final List<StockModel> openingStock;

  StockDisplayScreen(this.openingStock);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Display'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4,
      ),
      body: Container(
        color: Colors.grey[100], // Set a light background color
        padding: const EdgeInsets.all(16.0), // Add padding around the body
        child: openingStock.isEmpty // Check if the opening stock list is empty
            ? Center(
                child: Text('No stock available',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Allows horizontal scrolling
                child: SingleChildScrollView(
                  scrollDirection:
                      Axis.vertical, // Allows vertical scrolling (if needed)
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(
                          16.0), // Add more padding inside the card
                      child: DataTable(
                        columnSpacing: 16, // Add spacing between columns
                        columns: const [
                          DataColumn(
                            label: Text(
                              'Item Code',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Quantity',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Unit Of Measure',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        rows: openingStock.map((stock) {
                          return DataRow(cells: [
                            DataCell(Text(stock.code)),
                            DataCell(Text(stock.quantityDisplay.toString())),
                            DataCell(Text(stock.unit)),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
