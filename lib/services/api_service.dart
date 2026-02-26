import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static Future<List<Product>> fetchProducts() async {
    final res = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    final List data = json.decode(res.body);
    return data.map((e) => Product.fromJson(e)).toList();
  }
}
