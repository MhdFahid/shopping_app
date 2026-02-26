import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../services/api_service.dart';

class ProductListController extends ChangeNotifier {
  bool isLoading = false;
  List<Product> products = [];

  Future<void> fetchProducts({String? categorySlug}) async {
    isLoading = true;
    products = []; // Clear existing products
    notifyListeners();
    try {
      products = await ApiService.fetchProducts(categorySlug: categorySlug);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
