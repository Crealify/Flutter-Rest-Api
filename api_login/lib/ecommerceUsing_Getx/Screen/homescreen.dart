import 'package:api_login/ecommerceUsing_Getx/model/model.dart';
import 'package:api_login/ecommerceUsing_Getx/services/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageGetx extends StatefulWidget {
  final ProductController productController = Get.put(ProductController());

  HomePageGetx({super.key});

  @override
  State<HomePageGetx> createState() => _HomePageGetxState();
}

class _HomePageGetxState extends State<HomePageGetx> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: Icon(Icons.menu),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return GridView.builder(
                itemCount: widget.productController.productItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {},
              );
            }),
          ),
        ],
      ),
    );
  }
}

class ProductItemsDisplay extends StatelessWidget {
  final Product product;
  const ProductItemsDisplay({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          
        ],
      ),
    );
  }
}
