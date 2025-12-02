import 'package:flutter/material.dart';
import 'package:esercizio_3_1/main.dart';
import 'package:provider/provider.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartNotifier>();
    final items = cart.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrello'),
      ),
      body: items.isEmpty
          ? const Center(child: Text('Il carrello è vuoto'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(item.product.name),
                          subtitle: Text(
                              "\$${item.product.price.toStringAsFixed(2)} x ${item.quantity} = \$${(item.product.price * item.quantity).toStringAsFixed(2)}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  cart.decrementItem(item);
                                },
                              ),
                              Text(item.quantity.toString()),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  cart.incrementItem(item);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Totale: \$${cart.totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
    );
  }
}
