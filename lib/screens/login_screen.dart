// ✅ Updated LoginScreen with Phone Number + OTP simulation (no backend yet)

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  bool otpSent = false;
  bool isLoading = false;

  Future<void> sendOtp() async {
    final phone = phoneController.text.trim();
    if (phone.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid 10-digit phone number')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    setState(() {
      otpSent = true;
      isLoading = false;
    });
  }

  Future<void> verifyOtp() async {
    final otp = otpController.text.trim();
    if (otp != "1234") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP. Try 1234')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("loggedIn", true);
    await prefs.setString("phone", phoneController.text.trim());

    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool("loggedIn") ?? false;
    if (loggedIn) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Login with Phone',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              if (otpSent)
                TextField(
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter OTP (use 1234)',
                    border: OutlineInputBorder(),
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : otpSent
                        ? verifyOtp
                        : sendOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF204E38),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(otpSent ? 'Verify OTP' : 'Send OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
