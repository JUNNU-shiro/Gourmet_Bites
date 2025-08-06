import 'package:flutter/material.dart';
import '../models/deal_model.dart';
import '../utils/saved_deals_manager.dart';

class DealDetailScreen extends StatefulWidget {
  final DealModel deal;

  const DealDetailScreen({super.key, required this.deal});

  @override
  State<DealDetailScreen> createState() => _DealDetailScreenState();
}

class _DealDetailScreenState extends State<DealDetailScreen> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = SavedDealsManager.isSaved(widget.deal);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        SavedDealsManager.saveDeal(widget.deal);
      } else {
        SavedDealsManager.removeDeal(widget.deal);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 250,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      widget.deal.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Text("Image not found")),
                    ),
                    Container(color: Colors.black26),
                    Positioned(
                      top: 40,
                      left: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      right: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.black,
                          ),
                          onPressed: toggleLike,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text("${widget.deal.stock} left", style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(widget.deal.logoPath),
                            radius: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(widget.deal.storeName,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star, size: 16, color: Colors.orange),
                              const SizedBox(width: 4),
                              Text("${widget.deal.rating} (${widget.deal.reviews})", style: const TextStyle(fontSize: 14)),
                            ],
                          ),
                          Text("€${widget.deal.originalPrice.toStringAsFixed(2)}",
                              style: const TextStyle(fontSize: 14, decoration: TextDecoration.lineThrough)),
                          Text("€${widget.deal.discountedPrice.toStringAsFixed(2)}",
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Collect: ${widget.deal.pickupTime}", style: const TextStyle(fontSize: 14)),
                          const Chip(label: Text("Tomorrow")),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(widget.deal.address, style: const TextStyle(fontSize: 14)),
                          ),
                        ],
                      ),
                      const Divider(height: 30),
                      const Text("What's in the bag?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 8),
                      const Text("It's a surprise! When you buy a Surprise Bag, it will be filled with the delicious food that the store has left at the end of the day."),
                      const SizedBox(height: 8),
                      Chip(label: Text(widget.deal.category)),
                      const Divider(height: 30),
                      const Text("Overall experience", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(widget.deal.rating.toStringAsFixed(1)),
                          const SizedBox(width: 4),
                          const Icon(Icons.star, size: 16, color: Colors.orange),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildRatingBar("Collection experience", widget.deal.collectionExp),
                      _buildRatingBar("Food quality", widget.deal.foodQuality),
                      _buildRatingBar("Variety of contents", widget.deal.variety),
                      _buildRatingBar("Food quantity", widget.deal.quantity),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/payment');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF204E38),
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text("Reserve", style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildRatingBar(String label, double percent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: percent,
          color: Colors.green,
          backgroundColor: Colors.grey[200],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
