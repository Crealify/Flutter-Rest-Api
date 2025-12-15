// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:api_login/update/update_model.dart';
import 'package:http/http.dart' as http;

class MyApiService {
  Future<UpdateModel?> updateData(String name, String job) async {
    Uri url = Uri.parse("https://reqres.in/api/users/2");
    var data = {"name": name, "job": job};
    var response = await http.put(
      url,
      headers: {
        // "Content-Type": "application/json",
        // "Accept": "application/json",
        "x-api-key": 'reqres_c5639f34cd2648b5999d0cd3ca27964b', // 👈 required
      },
      // body: jsonEncode(data),// result:{"updatedAt":"2025-12-15T09:28:25.178Z"}
      body:
          data, // result: "name":"Anil","job":"Flutter Developer","updatedAt":"2025-12-15T09:29:10.610Z"
    );

    try {
      if (response.statusCode == 200) {
        UpdateModel model = UpdateModel.fromJson(jsonDecode(response.body));
        print(response.body);
        print("Data Update Successfully");
        return model;
      } else {
        var error = jsonDecode(response.body);
        print("Unable to login: ${error['error']}");
      }
    } catch (e) {
      // print("Error: $e");
      print(e.toString());
    }
    return null;
  }
}
