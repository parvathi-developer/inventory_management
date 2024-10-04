import 'package:inventory_management/models/stock_models.dart';

class Invoice {
  final String customer;
  final List<StockModel> items;

  Invoice({required this.customer, required this.items});
}
