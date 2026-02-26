import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_routes.dart';
import 'product_list_controller.dart';
import '../../models/product_model.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({super.key});

  final controller = Get.put(ProductListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.products.isEmpty) {
          return const Center(child: Text("No products"));
        }
        return ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (_, i) {
            final Product p = controller.products[i];
            return ListTile(
              leading: Image.network(p.image, width: 50),
              title: Text(p.name),
              subtitle: Text("₹${p.price}"),
              onTap: () => Get.toNamed(Routes.productDetails, arguments: p),
            );
          },
        );
      }),
    );
  }
}
