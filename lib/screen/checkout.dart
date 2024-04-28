import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/shoppingcart_provider.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<ShoppingCart>(
              builder: (context, cart, child) {
                return cart.cart.isEmpty
                    ? const Text("No items to checkout")
                    : ElevatedButton(
                        onPressed: () {
                          // Process the payment
                          cart.removeAll();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Payment Successful"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: const Text("Pay Now"),
                      );
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Go back to Cart"),
            ),
          ],
        ),
      ),
    );
  }
}