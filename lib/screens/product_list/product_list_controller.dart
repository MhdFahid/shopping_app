import 'package:get/get.dart';
import '../../models/product_model.dart';
import '../../services/api_service.dart';

class ProductListController extends GetxController {
  var isLoading = false.obs;
  var products = <Product>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    isLoading.value = true;
    try {
      products.value = await ApiService.fetchProducts();
    } finally {
      isLoading.value = false;
    }
  }
}
