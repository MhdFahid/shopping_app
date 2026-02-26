import 'package:flutter/material.dart';
import '../../services/home_service.dart';
import '../../utils/token_storage.dart';
import '../../models/home_data_model.dart';

class HomeController extends ChangeNotifier {
  HomeDataModel? homeData;
  bool isLoading = false;
  String? error;

  Future<void> getHomeData() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final token = await TokenStorage.getToken();
      final id = await TokenStorage.getUserId();

      if (token != null && id != null) {
        homeData = await HomeService.fetchHomeData(id: id, token: token);
      } else {
        error = "Authentication data missing";
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
