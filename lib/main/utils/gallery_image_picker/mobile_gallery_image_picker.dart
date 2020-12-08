import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

Future<Image> gallery_image_picker() async {
  ImagePicker picker = ImagePicker();
  PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
  return Image.file(File(pickedFile.path));
}
