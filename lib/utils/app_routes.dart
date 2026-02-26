import 'package:get/get.dart';
import '../screens/login/login_page.dart';
import '../screens/home/home_page.dart';
import '../screens/product_list/product_list_page.dart';
import '../screens/product_details/product_details_page.dart';

class Routes {
  static const login = '/login';
  static const home = '/home';
  static const productList = '/productList';
  static const productDetails = '/productDetails';
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.login, page: () => LoginPage()),
    GetPage(name: Routes.home, page: () => HomePage()),
    GetPage(name: Routes.productList, page: () => ProductListPage()),
    GetPage(name: Routes.productDetails, page: () => ProductDetailsPage()),
  ];
}
