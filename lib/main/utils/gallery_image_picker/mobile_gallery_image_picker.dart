import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

Future<Map<String, dynamic>> gallery_image_picker() async {
  ImagePicker picker = ImagePicker();
  PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
  return {
    'imageName': pickedFile.path,
    'imageData': await pickedFile.readAsBytes()
  };
  //return Image.file(File(pickedFile.path));
}
