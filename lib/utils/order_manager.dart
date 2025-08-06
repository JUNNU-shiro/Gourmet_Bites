// ✅ FILE: lib/utils/order_manager.dart
import '../models/deal_model.dart';

class OrderManager {
  static final List<DealModel> _orders = [];

  static void addOrder(DealModel deal) {
    _orders.add(deal);
  }

  static List<DealModel> getOrders() {
    return _orders;
  }

  static void clearOrders() {
    _orders.clear();
  }
}
