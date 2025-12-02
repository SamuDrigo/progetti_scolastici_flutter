import 'package:flutter/material.dart';
import 'package:esercizio_3_1/main.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.read<ProductProvider>().products;
    final cart = context.watch<CartNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  GoRouter.of(context).go('/cart');
                },
              ),
              if (cart.itemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cart.itemCount.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(product.name),
              subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
              trailing: ElevatedButton(
                onPressed: () {
                  cart.addItem(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${product.name} aggiunto al carrello")),
                  );
                },
                child: const Text('Aggiungi'),
              ),
            ),
          );
        },
      ),
    );
  }
}
