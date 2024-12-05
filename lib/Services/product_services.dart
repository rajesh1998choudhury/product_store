import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:product_store/Models/product.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await rootBundle.loadString('assets/products.json');
      final data = json.decode(response) as List;
      return data.map((productJson) => Product.fromJson(productJson)).toList();
    } catch (error) {
      if (kDebugMode) {
        print("Error loading products: $error");
      }
      rethrow;
    }
  }
}
