import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login/login_controller.dart';
import 'screens/product_list/product_list_controller.dart';
import 'screens/cart/cart_controller.dart';
import 'screens/home/home_controller.dart';

import 'screens/login/auth_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => ProductListController()),
        ChangeNotifierProvider(create: (_) => CartController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const AuthWrapper(),
      ),
    );
  }
}
