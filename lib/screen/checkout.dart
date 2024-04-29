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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              "Item Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Consumer<ShoppingCart>(
                builder: (context, cart, child) {
                  return ListView.builder(
                    itemCount: cart.cart.length,
                    itemBuilder: (context, index) {
                      final item = cart.cart[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text("Quantity: ${item.quantity}"),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Consumer<ShoppingCart>(
              builder: (context, cart, child) {
                return Text(
                  "Total Cost to Pay: ${cart.cartTotal}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Process the payment
              context.read<ShoppingCart>().removeAll();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Payment Successful"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text("Pay Now!"),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Go back to Cart"),
          ),
        ],
      ),
    );
  }
}