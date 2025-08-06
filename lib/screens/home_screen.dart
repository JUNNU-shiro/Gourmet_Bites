// 📄 lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'browse_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Meals', 'icon': Icons.fastfood, 'color': Colors.orange},
      {'name': 'Bakery', 'icon': Icons.cake, 'color': Colors.brown},
      {'name': 'Grocery', 'icon': Icons.shopping_bag, 'color': Colors.green},
      {'name': 'Pharmacy', 'icon': Icons.local_hospital, 'color': Colors.red},
      {'name': 'Cafes', 'icon': Icons.local_cafe, 'color': Colors.blueGrey},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF204E38),
      appBar: AppBar(
        backgroundColor: const Color(0xFF204E38),
        title: const Text('StreetRadar'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BrowseScreen()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(category['icon'] as IconData, color: category['color'] as Color, size: 40),
                    const SizedBox(height: 10),
                    Text(
                      category['name'] as String,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
