import 'package:flutter/material.dart';
import 'package:product_store/Models/product.dart';

//model cart
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

///

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  int get itemCount {
    int totalCount = 0;
    _items.forEach((_, cartItem) => totalCount += cartItem.quantity);
    return totalCount;
  }

  double get totalPrice {
    double total = 0.0;
    _items.forEach((_, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id.toString())) {
      _items[product.id.toString()]!.quantity += 1;
    } else {
      _items[product.id.toString()] = CartItem(product: product, quantity: 1);
    }
    notifyListeners();
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity > 0) {
      _items[productId]!.quantity = quantity;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }
}
