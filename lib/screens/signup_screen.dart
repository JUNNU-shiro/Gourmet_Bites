import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool acceptTerms = false;
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  void _signup() {
    if (_formKey.currentState!.validate() && acceptTerms) {
      // ✅ Correctly navigating to bottom nav main screen
      Navigator.pushReplacementNamed(context, '/');
    } else if (!acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please accept the Terms & Conditions")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: const Color(0xFF204E38),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (value) => value!.isEmpty ? 'Enter phone number' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => hidePassword = !hidePassword),
                  ),
                ),
                validator: (value) => value!.length < 6 ? 'Min 6 characters' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: hideConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  suffixIcon: IconButton(
                    icon: Icon(hideConfirmPassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => hideConfirmPassword = !hideConfirmPassword),
                  ),
                ),
                validator: (value) =>
                    value != passwordController.text ? 'Passwords do not match' : null,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Checkbox(
                    value: acceptTerms,
                    onChanged: (value) => setState(() => acceptTerms = value!),
                  ),
                  const Text('I accept the Terms & Conditions'),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _signup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF204E38),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
