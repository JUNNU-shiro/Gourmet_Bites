import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _quantity = 1;
  String _selectedPayment = 'Google Pay';
  bool _isProcessing = false;

  double get _unitPrice => 4.99;
  double get _totalPrice => _unitPrice * _quantity;

  void _handlePayNow() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isProcessing = false);
    if (!mounted) return;
    Navigator.pushNamed(context, '/confirmation');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: const Color(0xFF204E38),
        actions: [
    IconButton(
      icon: const Icon(Icons.person,color: Colors.white),
      onPressed: () {
        Navigator.pushNamed(context, '/profile'); // ✅ Route to your profile screen
      },
    ),
  ],

      ),
      
      backgroundColor: const Color(0xFFFCF5FF),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your Order', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Surprise Bag from MadeCoffee'),
                Text('€${_unitPrice.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Quantity'),
                Row(
                  children: [
                    IconButton(
                      onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
                      icon: const Icon(Icons.remove),
                    ),
                    Text('$_quantity'),
                    IconButton(
                      onPressed: () => setState(() => _quantity++),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('€${_totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Select Payment Method', style: TextStyle(fontWeight: FontWeight.w600)),
            RadioListTile(
              title: const Text('Credit / Debit Card'),
              value: 'Card',
              groupValue: _selectedPayment,
              onChanged: (val) => setState(() => _selectedPayment = val!),
            ),
            RadioListTile(
              title: const Text('Google Pay'),
              value: 'Google Pay',
              groupValue: _selectedPayment,
              onChanged: (val) => setState(() => _selectedPayment = val!),
            ),
            RadioListTile(
              title: const Text('Paytm'),
              value: 'Paytm',
              groupValue: _selectedPayment,
              onChanged: (val) => setState(() => _selectedPayment = val!),
            ),
            RadioListTile(
              title: const Text('Apple Pay'),
              value: 'Apple Pay',
              groupValue: _selectedPayment,
              onChanged: (val) => setState(() => _selectedPayment = val!),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _handlePayNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF204E38),
                ),
                child: _isProcessing
                    ? const Text('Redirecting to Google Pay...')
                    : const Text('Pay Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
