import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import './auth_service.dart';

import '../models/home_data_model.dart';

class HomeService {
  static Future<HomeDataModel> fetchHomeData({
    required String id,
    required String token,
  }) async {
    final url = Uri.parse(
      "${AuthService.baseUrl}/home/en",
    ).replace(queryParameters: {'id': id, 'token': token});

    debugPrint("Fetching Home Data from: $url");

    final response = await http.post(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return HomeDataModel.fromJson(data);
    } else {
      debugPrint("Home Data Loading Failed!");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");
      throw Exception("Failed to load home data: ${response.statusCode}");
    }
  }
}
