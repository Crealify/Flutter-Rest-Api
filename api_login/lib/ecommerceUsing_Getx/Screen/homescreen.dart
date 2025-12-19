import 'package:api_login/ecommerceUsing_Getx/Screen/productitem_display.dart';
import 'package:api_login/ecommerceUsing_Getx/model/model.dart';
import 'package:api_login/ecommerceUsing_Getx/services/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class HomePageGetx extends StatelessWidget {
//   // final ProductController productController = Get.put(ProductController());
//   final ProductController productController = Get.find();

//   HomePageGetx({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,

//         leading: Icon(Icons.menu),
//         actions: [
//           IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Obx(() {
//               if (productController.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (productController.productItems.isEmpty) {
//                 return const Center(child: Text("No products found"));
//               } else {
//                 return GridView.builder(
//                   itemCount: productController.productItems.length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 12,
//                     mainAxisSpacing: 12,
//                     childAspectRatio: 0.65,
//                   ),
//                   itemBuilder: (context, index) {
//                     return ProductItemsDisplay(
//                       product: productController.productItems[index],
//                     );
//                   },
//                 );
//               }
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ProductItemsDisplay extends StatelessWidget {
//   final Product product;
//   const ProductItemsDisplay({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: 5,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 160,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               image: DecorationImage(image: NetworkImage(product.image)),
//             ),
//           ),
//           SizedBox(height: 10),
//           Text(
//             product.title,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.green,
//                 ),
//                 child: Row(
//                   children: [
//                     Text(
//                       product.rating.rate.toString(),
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                     SizedBox(width: 5),
//                     Icon(Icons.star, color: Colors.white),
//                   ],
//                 ),
//               ),
//               Text(
//                 product.category.name.toLowerCase(),
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           SizedBox(height: 10),
//           Text("\$${product.price}", style: TextStyle(fontSize: 20)),
//         ],
//       ),
//     );
//   }
// }

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
          padding: const EdgeInsets.all(12), // ⭐ added padding
          itemCount: productController.productItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.70, // 🔥 FIXED
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
