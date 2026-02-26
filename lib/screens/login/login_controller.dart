import 'package:get/get.dart';
import '../../utils/app_routes.dart';

class LoginController extends GetxController {
  RxString email = ''.obs;
  RxString password = ''.obs;

  RxString validEmail = "mobile@alisonsgroup.com";
  RxString validPassword = "12345678";

  void login() {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar("Error", "Fields cannot be empty");
      return;
    }

    if (email.value == validEmail && password.value == validPassword) {
      Get.offAllNamed(Routes.home);
    } else {
      Get.snackbar("Error", "Invalid credentials");
    }
  }
}
