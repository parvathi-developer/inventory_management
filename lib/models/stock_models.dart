class StockModel {
  final String code;
  final int initialQuantity; // Initial stock in warehouse
  int salesQuantity; // Total quantity sold
  int returnQuantity; // Total quantity returned
  final String unit;

  StockModel({
    required this.code,
    required this.initialQuantity,
    this.salesQuantity = 0,
    this.returnQuantity = 0,
    required this.unit,
  });

  // Calculate the ending quantity based on sales and returns
  int get endingQuantity {
    return initialQuantity - salesQuantity + returnQuantity;
  }

  String get quantityDisplay {
    // Display the calculation in the specified format
    return '$initialQuantity - $salesQuantity + $returnQuantity = $endingQuantity';
  }
}
