import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../services/api_service.dart';

class CartController extends ChangeNotifier {
  final Map<Product, int> cartItems = {};

  Future<void> addToCart(Product product) async {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
    } else {
      cartItems[product] = 1;
    }
    notifyListeners();

    // API Sync
    if (product.slug != null) {
      await ApiService.addToCartApi(product.slug!, 1);
    }
  }

  Future<void> increaseQuantity(Product product) async {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
      notifyListeners();
      if (product.slug != null) {
        await ApiService.addToCartApi(product.slug!, 1);
      }
    }
  }

  Future<void> decreaseQuantity(Product product) async {
    if (cartItems.containsKey(product) && cartItems[product]! > 1) {
      cartItems[product] = cartItems[product]! - 1;
      notifyListeners();
      // Note: Ideally there would be a remove functionality or negative quantity in API,
      // but for now we follow the add with quantity pattern or just update local.
    } else if (cartItems.containsKey(product) && cartItems[product] == 1) {
      cartItems.remove(product);
      notifyListeners();
    }
  }

  int get totalItems => cartItems.values.fold(0, (sum, qty) => sum + qty);

  double get totalPrice {
    double total = 0;
    cartItems.forEach((product, qty) {
      total += (double.tryParse(product.price) ?? 0.0) * qty;
    });
    return total;
  }

  int getItemQuantity(int productId) {
    for (var entry in cartItems.entries) {
      if (entry.key.id == productId) return entry.value;
    }
    return 0;
  }

  void removeFromCart(Product product) {
    decreaseQuantity(product);
  }
}
