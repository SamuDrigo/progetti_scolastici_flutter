import 'package:flutter/material.dart';
import 'package:esercizio_3_1/product.dart';
import 'package:esercizio_3_1/cartItem.dart';
import 'package:esercizio_3_1/screens/cartScreen.dart';
import 'package:esercizio_3_1/screens/productScreen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BroccoShop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/products',
  routes: [
    GoRoute(
      path: '/products',
      builder: (context, state) => const ProductScreen(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
  ],
);

class ProductProvider {
  final List<Product> products = [
    Product(name: "Laptop", price: 449.99),
    Product(name: "Mouse", price: 39.99),
    Product(name: "Laptop Bag", price: 14.99),
  ];
}

class CartNotifier extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + item.product.price * item.quantity);

  void addItem(Product product) {
    final index = _items.indexWhere((i) => i.product.name == product.name);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void incrementItem(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decrementItem(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }
}

