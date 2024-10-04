import 'package:get/get.dart';
import 'package:inventory_management/models/invoice_models.dart';
import 'package:inventory_management/models/stock_models.dart';

class InventoryController extends GetxController {
  var openingStock = <StockModel>[].obs;
  var salesCount = 0.obs;
  var returnCount = 0.obs;

  var invoiceModel = <Invoice>[].obs;

  void addOpeningStock(String code, int quantity, String unit) {
    openingStock.add(StockModel(
      code: code,
      initialQuantity: quantity,
      unit: unit,
    ));
  }

  // Method to get total sales quantity from opening stock
  int get totalSalesCount {
    return salesCount.value;
  }

  // Method to get total return quantity from opening stock
  int get totalReturnCount {
    return returnCount.value;
  }

  void addInvoiceOrReturn(String customerName, List<StockModel> items,
      {bool isReturn = false}) {
    // Check if an invoice with the same customer name already exists
    Invoice? existingInvoice = invoiceModel.firstWhere(
      (invoice) => invoice.customer.toLowerCase() == customerName.toLowerCase(),
      orElse: () =>
          Invoice(customer: customerName, items: []), // Return a new Invoice
    );

    if (isReturn) {
      // Handle sales return logic

      salesCount.value += items.length; // Update return count

      // Update opening stock based on returns
      for (var item in items) {
        final existingItem = openingStock.firstWhere(
          (stockItem) =>
              stockItem.code.toLowerCase() == item.code.toLowerCase(),
          orElse: () =>
              StockModel(code: item.code, initialQuantity: 0, unit: item.unit),
        );

        // Update the existing item or add a new one
        existingItem.salesQuantity +=
            item.salesQuantity; // Update return quantity
      }

      if (existingInvoice.items.isNotEmpty) {
        existingInvoice.addItems(items,
            isReturn:
                isReturn); // Assuming addItems is a method in your Invoice class
      } else {
        Invoice newInvoice = Invoice(customer: customerName, items: items);
        invoiceModel.add(newInvoice);
      }
    } else {
      returnCount += items.length; // Update sales count

      // Update opening stock based on sales
      for (var item in items) {
        final existingItem = openingStock.firstWhere(
          (stockItem) =>
              stockItem.code.toLowerCase() == item.code.toLowerCase(),
          orElse: () =>
              StockModel(code: item.code, initialQuantity: 0, unit: item.unit),
        );

        // Update the existing item or add a new one
        existingItem.returnQuantity +=
            item.returnQuantity; // Update sales quantity
      }
      // Handle sales invoice logic
      if (existingInvoice.items.isNotEmpty) {
        existingInvoice.addItems(items,
            isReturn: isReturn); // Add items to existing invoice
      } else {
        Invoice newInvoice = Invoice(customer: customerName, items: items);
        invoiceModel.add(newInvoice);
      }
    }
  }
}
