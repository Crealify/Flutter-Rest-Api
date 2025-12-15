//https://reqres.in/ for api
// https://jsonplaceholder.typicode.com/users
// ignore_for_file: avoid_print

import 'package:api_login/getMethodWithoutModel/services.dart';
import 'package:flutter/material.dart';

class GetMethodWithoutModel extends StatefulWidget {
  const GetMethodWithoutModel({super.key});

  @override
  State<GetMethodWithoutModel> createState() => _GetMethodWithoutModelState();
}

class _GetMethodWithoutModelState extends State<GetMethodWithoutModel> {
  // TextEditingController nameController = TextEditingController();
  // TextEditingController jobController = TextEditingController();
  dynamic postModelData = [];
  bool isLoading = false;
  getPost() {
    isLoading = true;
    ApiService()
        .getResponseWithoutModel()
        .then((value) {
          setState(() {
            postModelData = value;
            isLoading = false;
          });
        })
        .onError((error, stackTrace) {
          print(error);
        });
  }

  @override
  void initState() {
    getPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Get Method Without Model",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: postModelData.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    color: Colors.blue.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          userInfo(
                            index,
                            "Name: ",
                            postModelData[index]["name"].toString(),
                          ),
                          userInfo(
                            index,
                            "Username: ",
                            postModelData[index]["username"].toString(),
                          ),

                          userInfo(
                            index,
                            "Email: ",
                            postModelData[index]["email"].toString(),
                          ),
                          userInfo(
                            index,
                            "Address: ",
                            postModelData[index]["address"]["city"].toString(),
                          ),
                          userInfo(
                            index,
                            "Street: ",
                            postModelData[index]['address']["street"]
                                .toString(),
                          ),
                          userInfo(
                            index,
                            "Phone: ",
                            postModelData[index]["phone"].toString(),
                          ),
                          userInfo(
                            index,
                            "Website: ",
                            postModelData[index]["website"].toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Row userInfo(int index, name, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(value, style: TextStyle(fontSize: 18)),
      ],
    );
  }
}
