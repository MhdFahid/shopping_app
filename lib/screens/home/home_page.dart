import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_routes.dart';
import '../cart/cart_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final cart = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Get.toNamed(Routes.productList),
          child: const Text("Go to Products"),
        ),
      ),
      bottomNavigationBar: Obx(() => Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              "Cart: ${cart.totalItems} items | ₹${cart.totalPrice.toStringAsFixed(2)}",
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}
