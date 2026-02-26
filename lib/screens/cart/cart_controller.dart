import 'package:get/get.dart';
import '../../models/product_model.dart';

class CartController extends GetxController {
  var cartItems = <Product, int>{}.obs;

  void addToCart(Product product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
    } else {
      cartItems[product] = 1;
    }
  }

  int get totalItems =>
      cartItems.values.fold(0, (sum, qty) => sum + qty);

  double get totalPrice {
    double total = 0;
    cartItems.forEach((product, qty) {
      total += product.price * qty;
    });
    return total;
  }
}
