import 'dart:typed_data';

import 'package:api_login/uploadImage/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  @override
  String isImageUpload = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isImageUpload == ""
                      ? SizedBox()
                      : SizedBox(
                          height: 350,
                          width: 350,
                          child: Image.network(isImageUpload),
                        ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image != null) {
                        setState(() {
                          isLoading = true;
                        });
                        Uint8List bytes = await image.readAsBytes();
                        UploadApiImage()
                            .uploadImage(bytes, image.name)
                            .then((value) {
                              setState(() {
                                isImageUpload = value['location'].toString();
                                isLoading = false;
                              });
                              print(
                                "Upload Sucessfully with link ${value.toString()}",
                              );
                            })
                            .onError((error, stackTrace) {
                              setState(() {
                                isLoading = true;
                              });
                              print(error.toString());
                            });
                      }
                    },

                    // onPressed: () async {
                    //   final picker = ImagePicker();
                    //   final image = await picker.pickImage(
                    //     source: ImageSource.gallery,
                    //   );
                    //   print(image?.path);
                    // },
                    child: const Text(
                      "Upload Image",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
