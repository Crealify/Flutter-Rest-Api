import 'package:api_login/ecommerceUsing_Getx/Screen/homescreen.dart';
import 'package:api_login/ecommerceUsing_Getx/services/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(ProductController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: const Color.fromARGB(255, 79, 76, 83),
        ),
      ),
      home: HomePageGetx(),
    );
  }
}
