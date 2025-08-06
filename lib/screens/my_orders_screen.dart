// ✅ lib/screens/my_orders_screen.dart
import 'package:flutter/material.dart';
import '../utils/order_manager.dart';
import '../models/deal_model.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DealModel> orders = OrderManager.getOrders();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: const Color(0xFF204E38),
      ),
      backgroundColor: const Color(0xFFFCF5FF),
      body: orders.isEmpty
          ? const Center(child: Text('No orders yet.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final deal = orders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Image.asset(
                      deal.imagePath,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(deal.storeName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text("Pickup: ${deal.pickupTime}"),
                        Text("€${deal.discountedPrice.toStringAsFixed(2)} x 1"),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
