import 'package:get/get.dart';
import 'package:inventory_management/models/invoice_models.dart';
import 'package:inventory_management/models/stock_models.dart';

class InventoryController extends GetxController {
  var openingStock = <StockModel>[].obs;
  var salesCount = 0.obs;
  var returnCount = 0.obs;

  void addOpeningStock(String code, int quantity, String unit) {
    openingStock.add(StockModel(
      code: code,
      initialQuantity: quantity,
      unit: unit,
    ));
  }

  void addSalesInvoice(String customerName, List<StockModel> items) {
    salesCount += items.length;
    for (var item in items) {
      final existingItem = openingStock.firstWhere(
          (stockItem) => stockItem.code == item.code,
          orElse: () =>
              StockModel(code: item.code, initialQuantity: 0, unit: item.unit));

      // Update the existing item or add a new one
      existingItem.salesQuantity += item.salesQuantity; // Update sales quantity
    }
    print(openingStock);
  }

  void addSalesReturn(String customerName, List<StockModel> items) {
    returnCount.value += items.length;
    for (var item in items) {
      final existingItem = openingStock.firstWhere(
          (stockItem) => stockItem.code == item.code,
          orElse: () =>
              StockModel(code: item.code, initialQuantity: 0, unit: item.unit));

      // Update the existing item or add a new one
      existingItem.returnQuantity +=
          item.returnQuantity; // Update return quantity
    }
  }

  // Method to get total sales quantity from opening stock
  int get totalSalesCount {
    return salesCount.value;
  }

  // Method to get total return quantity from opening stock
  int get totalReturnCount {
    return returnCount.value;
  }
}
