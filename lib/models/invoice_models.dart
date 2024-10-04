import 'package:inventory_management/models/stock_models.dart';

class Invoice {
  final String customer;
  final List<StockModel> items;

  Invoice({required this.customer, required this.items});

  void addItems(List<StockModel> newItems, {bool isReturn = false}) {
    for (var newItem in newItems) {
      // Check if the item already exists in the invoice
      var existingItem = items.firstWhere(
        (item) => item.code == newItem.code,
        orElse: () => StockModel(
            code: newItem.code, initialQuantity: 0, unit: newItem.unit),
      );

      // Update the existing item's sales quantity
      if (isReturn) {
        existingItem.salesQuantity += newItem.salesQuantity; // Merge quantities
      } else {
        existingItem.returnQuantity +=
            newItem.returnQuantity; // Merge quantities
      }
      // If the existing item was not in the invoice before, add it to the list
      if (!items.contains(existingItem)) {
        items.add(existingItem);
      }
    }
  }
}
