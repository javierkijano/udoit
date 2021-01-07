//import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:html' as html;

//library flutter_web_image_picker;

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

//import 'src/web_image_picker.dart';

//TODO: refactor so we have different methods depending on the format that we want
Future<Map<String, dynamic>> gallery_image_picker() async {
  return await _FlutterWebImagePicker._getImage;
}

class _FlutterWebImagePicker {
  /*
  static void registerWith(Registrar registrar) {
    final channel = MethodChannel('flutter_web_image_picker',
        const StandardMethodCodec(), registrar.messenger);
    final instance = _WebImagePicker();
    channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'pickImage':
          return await instance.pickImage();
        default:
          throw MissingPluginException();
      }
    });
  }

  static const MethodChannel _methodChannel =
      const MethodChannel('flutter_web_image_picker');

  */

  static Future<Map<String, dynamic>> get _getImage async {
    //final data =
    //    await _methodChannel.invokeMapMethod<String, dynamic>('pickImage');
    final image = await _WebImagePicker().pickImage();
    final imageData = base64.decode(image['data']);
    //return Image.memory(imageData, semanticLabel: imageName);
    return {'name': image['name'], 'data': imageData, 'path': image['path']};
  }
}

class _WebImagePicker {
  Future<Map<String, dynamic>> pickImage() async {
    print('pickImage');
    final Map<String, dynamic> data = {};
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input..accept = 'image/*';
    input.click();
    await input.onChange.first;
    if (input.files.isEmpty) return null;
    final reader = html.FileReader();
    reader.readAsDataUrl(input.files[0]);
    await reader.onLoad.first;
    final encoded = reader.result as String;
    // remove data:image/*;base64 preambule
    final stripped =
        encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
    //final imageBase64 = base64.decode(stripped);
    final imageName = input.files?.first?.name;
    final imagePath = input.files?.first?.relativePath;
    data.addAll({'name': imageName, 'data': stripped, 'path': imagePath});
    return data;
  }
}
