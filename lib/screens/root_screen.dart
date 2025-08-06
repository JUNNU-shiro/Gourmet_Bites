import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_tab_navigator.dart';
import 'login_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool("loggedIn") ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return isLoggedIn! ? const MainTabNavigator() : const LoginScreen();
  }
} 