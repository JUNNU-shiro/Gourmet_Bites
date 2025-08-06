import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        backgroundColor: const Color(0xFF1B4332), // 🌿 same green as other screens
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text("Current Password", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter current password",
              ),
            ),
            const SizedBox(height: 20),
            const Text("New Password", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter new password",
              ),
            ),
            const SizedBox(height: 20),
            const Text("Confirm New Password", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Re-enter new password",
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // 🔐 Placeholder: Add Firebase logic to change password here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B4332),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text("Change Password", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
