import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Email"),
              onChanged: (v) => controller.email.value = v,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
              onChanged: (v) => controller.password.value = v,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.login,
              child: const Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
