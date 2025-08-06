import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with Firebase user data
    const String name = 'John Doe';
    const String email = 'johndoe@example.com';

    // TODO: Replace with real summary data
    const int totalOrders = 8;
    const String lastOrderTime = '2 days ago';
    const double totalSaved = 32.75;

    return Scaffold(
      backgroundColor: const Color(0xFF204E38), // Dark green
      appBar: AppBar(
        backgroundColor: const Color(0xFF204E38),
        elevation: 0,
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 16),
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.green[100],
                child: const Icon(Icons.person, size: 40, color: Colors.green),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Center(child: Text(email, style: const TextStyle(color: Colors.grey))),
            const SizedBox(height: 30),
            const Divider(),
            const Text("Account", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.lock_outline),
              title: const Text("Change Password"),
              onTap: () {
                Navigator.pushNamed(context, '/change-password');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Log Out"),
              onTap: () => _logout(context),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Text("Order Summary", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: Text("Total Orders Made: $totalOrders"),
            ),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: Text("Last Order: $lastOrderTime"),
            ),
            ListTile(
              leading: const Icon(Icons.savings),
              title: Text("Total Saved: €${totalSaved.toStringAsFixed(2)}"),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("loggedIn");
    await prefs.remove("phone");
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
