import 'package:api_login/API%20using%20DIO/cart_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHomePage extends StatefulWidget {
  const DioHomePage({super.key});

  @override
  State<DioHomePage> createState() => _DioHomePageState();
}

class _DioHomePageState extends State<DioHomePage> {
  Cart? cart;
  Future<void> getData() async {
    const String apiUrl =
        'https://dummyjson.com/carts'; //this json is complex : search dummy json and take carts
    try {
      Response response = await Dio().get(apiUrl);
      if (response.data != null) {
        setState(() {
          cart = Cart.fromJson(response.data);
        });
      } else {
        throw Exception("Api response is null or in an unexpected format");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fetch Data from Api Using Dio",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: cart == null
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: cart!.carts!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                return Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                    children: [
                      Image.network(
                        cart!.carts![index].products![0].thumbnail ?? "",
                        height: 140,
                        width: 200,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
// the reason behind type "int" is not a subtype of type 'double?' error is
// some api items value is oth the format int and double but it defined as one value
