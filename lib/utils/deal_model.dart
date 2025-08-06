// 🔹 lib/utils/order_manager.dart
import '../models/deal_model.dart';

class OrderManager {
  static final List<DealModel> _orders = [];

  static List<DealModel> get orders => _orders;

  static void addOrder(DealModel deal) {
    _orders.add(deal);
  }

  static void clearOrders() {
    _orders.clear();
  }
}
