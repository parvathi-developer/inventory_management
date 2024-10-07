class StockModel {
  final String code;
  final int initialQuantity; // Initial stock in warehouse
  int salesQuantity; // Total quantity sold
  int returnQuantity; // Total quantity returned
  final String unit;
  String? lengthOFSales;

  StockModel(
      {required this.code,
      required this.initialQuantity,
      this.salesQuantity = 0,
      this.returnQuantity = 0,
      required this.unit,
      this.lengthOFSales = "0"});

  // Calculate the ending quantity based on sales and returns
  int get endingQuantity {
    return initialQuantity - salesQuantity + returnQuantity;
  }

  String get quantityDisplay {
    // Display the calculation in the specified format
    return '$initialQuantity - $salesQuantity + $returnQuantity = $endingQuantity';
  }

  void setLegthOfSales(int value) {
    if (lengthOFSales != "0") {
      lengthOFSales = lengthOFSales! + "+" + value.toString();
    } else {
      lengthOFSales = value.toString();
    }
  }

  String get lengthOfSales {
    if (lengthOFSales != "") {
      return lengthOfSales;
    }
    return 0.toString();
  }
}
