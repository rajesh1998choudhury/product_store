import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:product_store/Common_Widgets/product_grid_item.dart';
import 'package:product_store/Models/product.dart';
import 'package:product_store/Services/product_services.dart';
import 'package:product_store/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Product Catalog'),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: cartProvider.itemCount > 0
                          ? Colors.black
                          : Colors.white,
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/cart'),
                  ),
                  if (cartProvider.itemCount > 0)
                    Positioned(
                      right: 7,
                      top: 7,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.blue,
                        child: Text(
                          cartProvider.itemCount.toString(),
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 80),
              Expanded(
                child: FutureBuilder<List<Product>>(
                  future: ProductService().fetchProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Failed to load products'));
                    } else {
                      return GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 3 / 4,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final product = snapshot.data![index];
                          return ProductGridItem(product: product);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          // Text Positioned
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  ScaleAnimatedText(
                    'Welcome to Our Shop',
                    textStyle: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    duration: const Duration(seconds: 5),
                  ),
                ],
                repeatForever: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
