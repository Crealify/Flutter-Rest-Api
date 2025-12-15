//https://reqres.in/ for api

// ignore_for_file: avoid_print

import 'package:api_login/update/service.dart';
import 'package:api_login/update/update_display.dart';
import 'package:api_login/update/update_model.dart';
import 'package:flutter/material.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  UpdateModel updateData = UpdateModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update: PUT APi"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(hintText: "Name"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: jobController,
              decoration: const InputDecoration(hintText: "Job"),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[200],
              ),
              onPressed: () {
                MyApiService()
                    .updateData(
                      nameController.text.toString(),
                      jobController.text.toString(),
                    )
                    .then((value) {
                      setState(() {
                        updateData = value!;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateDisplay(
                              updateModel: updateData,
                              name: updateData.name.toString(),
                              job: updateData.job.toString(),
                              updatedAT: updateData.updatedAt.toString(),
                            ),
                          ),
                        );
                      });
                    });
              },

              child: Text(
                "Update",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
