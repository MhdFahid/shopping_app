import 'package:get/get.dart';
import '../../models/product_model.dart';
import '../cart/cart_controller.dart';

class ProductDetailsController extends GetxController {
  late Product product;
  final cart = Get.find<CartController>();

  @override
  void onInit() {
    product = Get.arguments;
    super.onInit();
  }

  void addToCart() {
    cart.addToCart(product);
    Get.snackbar("Success", "Added to cart");
  }
}
