import 'package:flutter/material.dart';
import 'package:product_store/Common_Widgets/cart_item_tile.dart';
import 'package:product_store/Themes/colors.dart';
import 'package:product_store/providers/cart_provider.dart';
import 'package:product_store/screens/product_list_screen.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          'Your Cart Product',
          style: TextStyle(fontSize: 20, color: kTextColor),
        ),
      ),
      body: cartProvider.items.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: cartProvider.items.length,
                      itemBuilder: (context, index) {
                        final productId =
                            cartProvider.items.keys.elementAt(index);
                        final cartItem = cartProvider.items[productId]!;
                        return CartItemTile(cartItem: cartItem);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const Text('Total Price :',
                              style: TextStyle(fontSize: 28)),
                          Text(
                            ' ₹ ${cartProvider.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 28, color: Colors.green),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _showCheckoutDialog(context, cartProvider);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kMainColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                        child: const Text(
                          'Proceed to Checkout',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void _showCheckoutDialog(BuildContext context, CartProvider cartProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Checkout'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Total Price: ₹ ${cartProvider.totalPrice.toStringAsFixed(2)}'),
              const SizedBox(height: 10),
              const Text('Order Successful'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                cartProvider.items.clear();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductListScreen(),
                  ),
                  (route) => false,
                );
              },
              child: const Text(
                'OK',
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }
}
