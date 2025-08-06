import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/deal_detail_screen.dart';
import 'screens/checkout_screen.dart' as checkout;
import 'screens/confirmation_screen.dart' as confirm;
import 'screens/saved_deals_screen.dart';
import 'screens/my_orders_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/main_tab_navigator.dart'; // Browse + bottom nav
import 'screens/change_password_screen.dart';
import 'screens/root_screen.dart';
import 'models/deal_model.dart'; // <-- Needed to pass DealModel

void main() {
  runApp(const StreetRadarApp());
}

class StreetRadarApp extends StatelessWidget {
  const StreetRadarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StreetRadar',
      onGenerateRoute: (settings) {
        if (settings.name == '/deal') {
          final deal = settings.arguments as DealModel;
          return MaterialPageRoute(
            builder: (context) => DealDetailScreen(deal: deal),
          );
        }
        return null;
      },
      routes: {
        '/': (context) => const RootScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/payment': (context) => const checkout.CheckoutScreen(),
        '/confirmation': (context) => const confirm.ConfirmationScreen(),
        '/savedDeals': (context) => const SavedDealsScreen(),
        '/orders': (context) => const MyOrdersScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/change-password': (context) => const ChangePasswordScreen(),
      },
    );
  }
}
