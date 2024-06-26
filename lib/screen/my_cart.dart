import 'package:flutter/material.dart';
import '../model/item.dart';
import "package:provider/provider.dart";
import "../provider/shoppingcart_provider.dart";

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(
        "My Cart",
        style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 250, 128, 114),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getItems(context),
          computeCost(),
          // const Divider(height: 4, color: Colors.black),
          Flexible(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<ShoppingCart>().removeAll();
                    },
                    child: const Text("Reset"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (context.read<ShoppingCart>().cart.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("No items to checkout"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        Navigator.pushNamed(context, "/checkout");
                      }
                    },
                    child: const Text("Checkout"),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            child: const Text("Go back to Product Catalog"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget getItems(BuildContext context) {
  List<Item> products = context.watch<ShoppingCart>().cart;
  String productname = "";
  return products.isEmpty
      ? const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            'No Items yet!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      : Expanded(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: const Icon(Icons.food_bank),
                      title: Text(products[index].name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          productname = products[index].name;
                          context.read<ShoppingCart>().removeItem(productname);
                          if (products.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("$productname removed!"),
                              duration:
                                  const Duration(seconds: 1, milliseconds: 100),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Cart Empty!"),
                              duration: Duration(seconds: 1, milliseconds: 100),
                            ));
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
}

Widget computeCost() {
    return Consumer<ShoppingCart>(builder: (context, cart, child) {
      return Text("Total: ${cart.cartTotal}");
    });
  }
}