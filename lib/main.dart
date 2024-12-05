import 'package:flutter/material.dart';
import 'package:product_store/Screens/cart_screen.dart';
import 'package:product_store/Themes/colors.dart';
import 'package:product_store/providers/cart_provider.dart';
import 'package:product_store/screens/product_list_screen.dart';
import 'package:product_store/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Product Catalog',
        theme: ThemeData(primaryColor: kAppBackgroundColor),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          '/product-list': (context) => const ProductListScreen(),
          '/cart': (context) => const CartScreen(),
        },
      ),
    );
  }
}
