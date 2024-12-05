// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferencesUtil {
//   static Future<void> saveCart(Map<String, int> cart) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString('cart', cart.toString());
//   }

//   static Future<Map<String, int>> loadCart() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cartString = prefs.getString('cart') ?? '{}';
//     final Map<String, int> cart = {};
//     cartString.replaceAll(RegExp(r'[{} ]'), '').split(',').forEach((item) {
//       if (item.isNotEmpty) {
//         final pair = item.split(':');
//         cart[pair[0]] = int.parse(pair[1]);
//       }
//     });
//     return cart;
//   }
// }
