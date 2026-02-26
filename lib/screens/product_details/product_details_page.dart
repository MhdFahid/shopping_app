import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'product_details_controller.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({super.key});

  final controller = Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Scaffold(
      appBar: AppBar(title: Text(p.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(p.image, height: 200),
            const SizedBox(height: 10),
            Text(p.name, style: const TextStyle(fontSize: 20)),
            Text("₹${p.price}"),
            const SizedBox(height: 10),
            Text(p.description),
            const Spacer(),
            ElevatedButton(
              onPressed: controller.addToCart,
              child: const Text("Add to Cart"),
            )
          ],
        ),
      ),
    );
  }
}
