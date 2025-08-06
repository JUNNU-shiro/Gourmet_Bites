import 'package:flutter/material.dart';
import '../utils/saved_deals_manager.dart';
import '../models/deal_model.dart';
import 'deal_detail_screen.dart';

class SavedDealsScreen extends StatefulWidget {
  const SavedDealsScreen({super.key});

  @override
  State<SavedDealsScreen> createState() => _SavedDealsScreenState();
}

class _SavedDealsScreenState extends State<SavedDealsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Deals'),
        backgroundColor: const Color(0xFF204E38),
      ),
      body: SavedDealsManager.savedDeals.isEmpty
          ? const Center(child: Text('No saved deals yet'))
          : ListView.builder(
              itemCount: SavedDealsManager.savedDeals.length,
              itemBuilder: (context, index) {
                final deal = SavedDealsManager.savedDeals[index];
                return Card(
                  margin: const EdgeInsets.all(12),
                  child: ListTile(
                    leading: Image.asset(
                      deal.imagePath,
                      width: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image),
                    ),
                    title: Text(deal.title),
                    subtitle: Text(deal.storeName),
                    trailing:
                        Text('€${deal.discountedPrice.toStringAsFixed(2)}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DealDetailScreen(deal: deal),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
