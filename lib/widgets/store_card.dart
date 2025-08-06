import 'package:flutter/material.dart';

class StoreCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String time;
  final String distance;
  final String price;
  final String discount;
  final List<String>? tags;
  final VoidCallback? onTap;

  const StoreCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.distance,
    required this.price,
    required this.discount,
    this.tags,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.asset(imagePath, height: 160, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (tags != null && tags!.isNotEmpty)
                    Row(
                      children: tags!
                          .map((tag) => Container(
                                margin: const EdgeInsets.only(right: 6),
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(tag, style: const TextStyle(color: Colors.white, fontSize: 12)),
                              ))
                          .toList(),
                    ),
                  const SizedBox(height: 6),
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text('$time – $distance', style: const TextStyle(fontSize: 12, color: Colors.black87)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(price,
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          )),
                      const SizedBox(width: 10),
                      Text(discount,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
