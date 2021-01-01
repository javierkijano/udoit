import 'package:udoit/main/models/configuration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:udoit/main/utils/gallery_image_picker/generic_gallery_image_picker.dart';
import 'package:udoit/main/utils/hash.dart';
import 'dart:async';

class Initiative {
  String id;
  DateTime dateTime;
  Category category;
  String title;
  String destinatary;
  String request;
  List<Uint8image> uint8images;
  List<String> imagesUrls = [];
  String youtubeVideoUrl;

  Initiative(
      {this.dateTime,
      this.category,
      this.title,
      this.destinatary,
      this.request,
      this.uint8images,
      this.youtubeVideoUrl}) {
    this.id = generateMD5fromStringList(
        [this.dateTime.toIso8601String(), this.title.toString()]);
  }

  Map<String, dynamic> toJSON() {
    return {
      'dateTime': dateTime,
      'category': category.id,
      'title': title,
      'destinatary': destinatary,
      'request': request,
      'imagesUrls': imagesUrls,
      'youtubeVideoUrl': youtubeVideoUrl,
    };
  }
}

class Initiatives {
  CollectionReference _refStore;
  firebase_storage.Reference _refStorage;

  Initiatives() {
    _refStore = FirebaseFirestore.instance.collection('initiatives');
    _refStorage =
        firebase_storage.FirebaseStorage.instance.ref().child('initiatives');
  }

  Future add(Initiative initiative) async {
    List<Future<firebase_storage.TaskSnapshot>> _uploadTasks = [];

    for (Uint8image uint8image in initiative.uint8images) {
      final metadata = firebase_storage.SettableMetadata(
          contentType: 'image/jpeg', customMetadata: {'test': 'hola'});
      _uploadTasks.add(_refStorage
          .child(initiative.id)
          .child(uint8image.name)
          .putData(uint8image.data, metadata)
          .whenComplete(() {
        int a = 0;
      }));
    }

    await Future.wait(_uploadTasks);
    List<Future<String>> _imagesUrls = [];
    for (Uint8image uint8image in initiative.uint8images) {
      _imagesUrls.add(_refStorage
          .child(initiative.id)
          .child(uint8image.name)
          .getDownloadURL());
    }
    initiative.imagesUrls.addAll(await Future.wait(_imagesUrls));
    await _refStore.add(initiative.toJSON());
  }

  latest() {}

  popular() {}

  trending() {}
}

/// Enum representing the upload task types the example app supports.
enum UploadType {
  /// Uploads a randomly generated string (as a file) to Storage.
  string,

  /// Uploads a file from the device.
  file,

  /// Clears any tasks from the list.
  clear,
}
