import 'package:udoit/main/utils/gallery_image_picker/web_gallery_image_picker.dart'
    if (dart.library.io) 'package:udoit/main/utils/mobile_gallery_image_picker.dart';
import 'package:flutter/material.dart';

Future<Map<String, dynamic>> generic_gallery_image_picker() async {
  return await gallery_image_picker();
}
