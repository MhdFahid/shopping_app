import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import './auth_service.dart';
import '../utils/token_storage.dart';
import '../models/product_model.dart';

class ApiService {
  static Future<List<Product>> fetchProducts({String? categorySlug}) async {
    final token = await TokenStorage.getToken() ?? '';
    final id = await TokenStorage.getUserId() ?? '';

    final Map<String, String> queryParams = {'id': id, 'token': token};

    if (categorySlug != null) {
      queryParams['by'] = 'category';
      queryParams['value'] = categorySlug;
    }

    final url = Uri.parse(
      "${AuthService.baseUrl}/products/en",
    ).replace(queryParameters: queryParams);

    debugPrint("Fetching Products from: $url");

    final response = await http.post(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == 1) {
        // Handle nested structure: data['products']['products']
        final productsData = data['products'];
        final productsList =
            (productsData is Map && productsData['products'] != null)
            ? productsData['products'] as List
            : [];
        return productsList.map((e) => Product.fromJson(e)).toList();
      } else {
        return [];
      }
    } else {
      debugPrint("Products Loading Failed!");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");
      return [];
    }
  }

  static Future<Product?> fetchProductDetails(String slug) async {
    final token = await TokenStorage.getToken() ?? '';
    final id = await TokenStorage.getUserId() ?? '';

    final url = Uri.parse(
      "${AuthService.baseUrl}/product-details/en/$slug",
    ).replace(queryParameters: {'id': id, 'token': token, 'store': 'swan'});

    debugPrint("Fetching Product Details from: $url");

    try {
      final response = await http.post(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == 1 && data['products'] is Map) {
          // The API returns product details in the 'products' field
          return Product.fromJson(data['products'] as Map<String, dynamic>);
        }
      }
    } catch (e) {
      debugPrint("Error fetching product details: $e");
    }
    return null;
  }

  static Future<bool> addToCartApi(String slug, int quantity) async {
    final token = await TokenStorage.getToken() ?? '';
    final id = await TokenStorage.getUserId() ?? '';

    final url = Uri.parse("${AuthService.baseUrl}/cart/add/en").replace(
      queryParameters: {
        'id': id,
        'token': token,
        'slug': slug,
        'quantity': quantity.toString(),
        'store': 'swan',
      },
    );

    debugPrint("Adding to Cart via API: $url");

    try {
      final response = await http.post(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == 1;
      }
    } catch (e) {
      debugPrint("Error adding to cart: $e");
    }
    return false;
  }
}
