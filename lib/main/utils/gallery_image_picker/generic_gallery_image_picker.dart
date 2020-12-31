import 'dart:typed_data';

import 'package:udoit/main/utils/gallery_image_picker/web_gallery_image_picker.dart'
    if (dart.library.io) 'package:udoit/main/utils/mobile_gallery_image_picker.dart';
import 'package:flutter/material.dart';

class Uint8image {
  String name;
  Uint8List data;
  Uint8image(this.name, this.data);
}

Future<Uint8image> generic_gallery_image_picker() async {
  Map<String, dynamic> image = await gallery_image_picker();
  return Uint8image(image['name'], image['data']);
}
