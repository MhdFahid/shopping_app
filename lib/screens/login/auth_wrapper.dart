import 'package:flutter/material.dart';
import '../../utils/token_storage.dart';
import '../main/main_screen.dart';
import 'login_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: TokenStorage.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFF7B3A00)),
            ),
          );
        }

        if (snapshot.data == true) {
          return const MainScreen();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
