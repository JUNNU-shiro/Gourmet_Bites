import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('🟢 Confirmation Screen loaded!'); // Debug check

    return Scaffold(
      backgroundColor: const Color(0xFFEFFAF3),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle_outline, size: 100, color: Colors.green),
              const SizedBox(height: 20),
              
              const Text(
                'Order Confirmed!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF204E38),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Your surprise bag from MadeCoffee is reserved 🎉\n\nCollect it between 2:00 AM – 3:00 AM.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                icon: const Icon(Icons.home_outlined),
                label: const Text('Back to Home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF204E38),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
