import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageUpload extends StatelessWidget {
  final File? imageFile;
  final VoidCallback pickImageCallback;

  ImageUpload({required this.imageFile, required this.pickImageCallback});

  Future<String?> getImageBase64() async {
    if (imageFile == null) return null;

    List<int> imageBytes = await imageFile!.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    return base64Image;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImageCallback,
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(17.0),
        ),
        child: imageFile != null
            ? ClipRRect(
              borderRadius: BorderRadius.circular(17.0),
              child:  CachedNetworkImage(
                imageUrl: imageFile!.path,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),)
            : Icon(
                Icons.add,
                size: 40,
                color: Colors.grey,
              ),
      ),
    );
  }
}
