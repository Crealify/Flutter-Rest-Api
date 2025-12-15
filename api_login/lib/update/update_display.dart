// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:api_login/update/update_model.dart';
import 'package:flutter/material.dart';

class UpdateDisplay extends StatelessWidget {
  final String? name, job, updatedAT;
  final UpdateModel updateModel;
  const UpdateDisplay({
    this.name,
    this.job,
    super.key,
    this.updatedAT,
    required this.updateModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Api")),
      body: Center(
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Name: $name"),
            Text("Job: $job"),
            Text("Updated: $updatedAT"),
          ],
        ),
      ),
    );
  }
}
