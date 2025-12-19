import 'package:api_login/ecommerceUsing_Getx/model/model.dart';
import 'package:api_login/ecommerceUsing_Getx/services/remote_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var productItems = <Product>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchProduct();
    super.onInit();
  }

  void fetchProduct() async {
    try {
       isLoading(true);
      var products = await RemoteService.fetchProduct();
      if (products != null) {
        productItems.assignAll(products);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
