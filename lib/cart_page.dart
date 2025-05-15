import 'package:flutter/material.dart';
import 'cart_data.dart';
import 'checkout_page.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _removeItem(int index) {
    setState(() {
      CartData.items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = CartData.items;

    return Scaffold(
      appBar: AppBar(title: Text('Your Cart'), backgroundColor: Colors.blue),
      body:
          items.isEmpty
              ? Center(child: Text('Your cart is empty'))
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return ListTile(
                          leading: Image.asset(
                            item.imagePath,
                            width: 90,
                          ), // Increased image size
                          title: Text(item.name),
                          subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 30,
                            ), // Keep icon size large
                            onPressed: () => _removeItem(index),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        final cartItems =
                            items
                                .map(
                                  (item) => {
                                    'name': item.name,
                                    'price': item.price,
                                  },
                                )
                                .toList();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CheckoutPage(
                                  cartItems:
                                      CartData.items
                                          .map((item) => item.name)
                                          .toList(),
                                ),
                          ),
                        );
                      },
                      child: Text('Proceed to Checkout'),
                    ),
                  ),
                ],
              ),
    );
  }
}
