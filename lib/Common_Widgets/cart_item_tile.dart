import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:product_store/providers/cart_provider.dart';

class CartItemTile extends StatelessWidget {
  final CartItem cartItem;

  const CartItemTile({required this.cartItem, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                cartItem.product.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹ ${cartItem.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .updateQuantity(cartItem.product.id.toString(),
                              cartItem.quantity - 1);
                    },
                  ),
                  SizedBox(
                    width: 30,
                    child: Text(
                      '${cartItem.quantity}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .updateQuantity(cartItem.product.id.toString(),
                              cartItem.quantity + 1);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
