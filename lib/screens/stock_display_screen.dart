import 'package:flutter/material.dart';
import 'package:inventory_management/models/invoice_models.dart';
import 'package:inventory_management/models/stock_models.dart';

class StockDisplayScreen extends StatelessWidget {
  final List<StockModel> openingStock;

  StockDisplayScreen(this.openingStock);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stock Display')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Allows horizontal scrolling
        child: SingleChildScrollView(
          scrollDirection:
              Axis.vertical, // Allows vertical scrolling (if needed)
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Item Code')),
              DataColumn(label: Text('Quantity')),
              DataColumn(label: Text('Unit Of Measure')),
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
    );
    ;
  }
}
