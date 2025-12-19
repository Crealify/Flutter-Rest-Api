import 'package:api_login/ecommerceUsing_Getx/Screen/productitem_display.dart';
import 'package:api_login/ecommerceUsing_Getx/services/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageGetx extends StatelessWidget {
  final ProductController productController = Get.find();

  HomePageGetx({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        title: Text(
          "CEALIFY SHOP",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true ,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
          ),
        ],
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (productController.productItems.isEmpty) {
          return const Center(child: Text("No products found"));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: productController.productItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.70,
          ),
          itemBuilder: (context, index) {
            return ProductItemsDisplay(
              product: productController.productItems[index],
            );
          },
        );
      }),
    );
  }
}
