//fakestoreapi.com

import 'package:http/http.dart' as http;

import '../model/model.dart';

class RemoteService {
  static Future<List<Product>?> fetchProduct() async {
    var client = http.Client();

    var uri = Uri.parse("https://fakestoreapi.com/products");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return productFromJson(json);
    } else {
      print("Error Response : ${response.body}");
    }
    return null;
  }
}
