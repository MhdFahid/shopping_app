import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = "https://sungod.demospro2023.in.net/api";
  static const String imageBaseUrl = "https://sungod.demospro2023.in.net";

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(
      "$baseUrl/login?email_phone=$email&password=$password",
    );

    final response = await http.post(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Login failed");
    }
  }
}
