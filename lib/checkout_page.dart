import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CheckoutPage extends StatefulWidget {
  final List<String> cartItems;

  const CheckoutPage({super.key, required this.cartItems});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String address = '';

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Fade-in animation for the form fields
    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();

    // Scale animation for the button
    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _submitOrder() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Prepare order data
      final orderData = {
        'name': name,
        'email': email,
        'address': address,
        'items': widget.cartItems,
      };

      // URL to your Firebase function (replace with your actual project ID)
      final url =
          'https://us-central1-solana-eyewear-website-new.cloudfunctions.net/sendEmail';

      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(orderData),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Order submitted successfully!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong. Please try again.'),
            ),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send order. Please try again later.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                "Cart Items:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18, // Increase the font size of the title
                ),
              ),
              const SizedBox(height: 10),

              // Display cart items with larger font size
              ...widget.cartItems
                  .map(
                    (item) => Text(
                      "- $item",
                      style: TextStyle(fontSize: 18), // Make items larger
                    ),
                  )
                  .toList(),

              const SizedBox(height: 20),

              // Name TextField with full width and animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    onSaved: (value) => name = value ?? '',
                    validator:
                        (value) =>
                            value!.isEmpty ? 'Please enter your name' : null,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Email TextField with full width and animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) => email = value ?? '',
                    validator:
                        (value) =>
                            value!.isEmpty ? 'Please enter your email' : null,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Address TextField with full width and animation (no excessive height)
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Address'),
                    maxLines: 2, // Set to 2 lines to prevent excessive height
                    onSaved: (value) => address = value ?? '',
                    validator:
                        (value) =>
                            value!.isEmpty ? 'Please enter your address' : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Submit Button with scaling animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: ElevatedButton(
                    onPressed: _submitOrder,
                    child: const Text('Submit Order'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
