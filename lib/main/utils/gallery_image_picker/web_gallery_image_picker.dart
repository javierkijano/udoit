import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:flutter/material.dart';

Future<Image> gallery_image_picker() async {
  return await FlutterWebImagePicker.getImage;
}
