import 'package:flutter/material.dart';
import 'package:shopping_app/utils/token_storage.dart';
import '../../services/auth_service.dart';

class LoginController extends ChangeNotifier {
  String email = '';
  String password = '';
  bool _isVisible = false;

  bool get isVisible => _isVisible;

  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  bool isLoading = false;

  Future<bool> login(BuildContext context) async {
    if (email.isEmpty || password.isEmpty) {
      _show(context, "Fields cannot be empty");
      return false;
    }

    try {
      isLoading = true;
      notifyListeners();

      final res = await AuthService.login(email: email, password: password);

      isLoading = false;
      notifyListeners();

      // ✅ FIXED SUCCESS CHECK
      if (res["success"] == 1) {
        final token = res["customerdata"]["token"];
        final userId = res["customerdata"]["id"].toString();

        await TokenStorage.saveToken(token);
        await TokenStorage.saveUserId(userId);

        return true;
      } else {
        _show(context, res["message"] ?? "Login failed");
        return false;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      _show(context, "Login error");
      return false;
    }
  }

  void _show(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
