import 'package:flutter/material.dart';
import 'product_detail.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> productPrices = [
      '\$99.99',
      '\$149.99',
      '\$199.99',
      '\$129.99',
      '\$89.99',
      '\$159.99',
    ];

    List<String> productNames = [
      'Solana Classic',
      'Solana Modern',
      'Solana Retro',
      'Solana Bold',
      'Solana Sleek',
      'Solana Luxe',
    ];

    List<String> productDescriptions = [
      'Timeless design with lightweight materials.',
      'Bold, modern frame for trendsetters.',
      'Vintage-inspired for a retro feel.',
      'Striking look with reinforced durability.',
      'Slim profile with minimalist elegance.',
      'Luxury finish for premium style.',
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Shop Eyewear'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.75,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailPage(productIndex: index),
                  ),
                );
              },

              child: Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/Picture${index + 1}.jpg',
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        productNames[index],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Price: ${productPrices[index]}'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
