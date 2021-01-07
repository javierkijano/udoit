import 'package:udoit/models/configuration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:udoit/utils/gallery_image_picker/generic_gallery_image_picker.dart';
import 'package:udoit/utils/hash.dart';
import 'dart:async';

class Initiative {
  String publisherUserId;
  String id;
  DateTime dateTime;
  Category category;
  String title;
  String destinatary;
  String summary;
  String request;
  List<dynamic> uint8images;
  List<String> imagesUrls = [];
  String youtubeVideoUrl;

  Initiative(
      {this.publisherUserId,
      this.dateTime,
      this.category,
      this.title,
      this.destinatary,
      this.summary,
      this.request,
      this.uint8images,
      this.youtubeVideoUrl}) {
    assert(publisherUserId != null);
    //id generated from user user uuid and dateTime
    this.id = generateMD5fromStringList(
        [this.dateTime.toIso8601String(), this.publisherUserId]);
  }

  Initiative.fromJSON(Map<String, dynamic> data) {
    this.publisherUserId = data['publisherUserId'];
    this.dateTime = data['dateTime'];
    this.category = data['category'];
    this.title = data['title'];
    this.destinatary = data['destinatary'];
    this.summary = data['summary'];
    this.request = data['request'];
    this.uint8images = data['uint8images'];
    this.youtubeVideoUrl = data['youtubeVideoUrl'];
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'publisherUserId': publisherUserId,
      'dateTime': dateTime,
      'category': category.id,
      'title': title,
      'destinatary': destinatary,
      'summary': summary,
      'request': request,
      'imagesUrls': imagesUrls,
      'youtubeVideoUrl': youtubeVideoUrl,
    };
  }
}

class Initiatives {
  CollectionReference _refStore;
  firebase_storage.Reference _refStorage;
  int _previousTrendingQuerySeed;
  QueryDocumentSnapshot _lastDocFomPreviousQuery;

  Initiatives() {
    _refStore = FirebaseFirestore.instance.collection('initiatives');
    _refStorage =
        firebase_storage.FirebaseStorage.instance.ref().child('initiatives');
  }

  Future addToFirestore(Initiative initiative) async {
    List<Future<firebase_storage.TaskSnapshot>> _uploadTasks = [];

    for (Map<String, dynamic> uint8image in initiative.uint8images) {
      final metadata = firebase_storage.SettableMetadata(
          contentType: 'image/${uint8image['name'].split(".").last}',
          customMetadata: {'test': 'hola'});
      _uploadTasks.add(_refStorage
          .child(initiative.id)
          .child(uint8image['name'])
          .putData(uint8image['data'], metadata)
          .whenComplete(() {
        int a = 0;
      }).catchError((onError) {
        print('... ERROR uploading to firebase storage: $onError');
      }));
    }

    await Future.wait(_uploadTasks);
    List<Future<String>> _imagesUrls = [];
    for (Map<String, dynamic> uint8image in initiative.uint8images) {
      _imagesUrls.add(_refStorage
          .child(initiative.id)
          .child(uint8image['name'])
          .getDownloadURL());
    }
    initiative.imagesUrls.addAll(await Future.wait(_imagesUrls));
    Map<String, dynamic> data = initiative.toJSON();
    await _refStore.add(data).then((value) => null).catchError((onError) {
      print('... ERROR uploading to firestore: $onError');
    });
  }

  latest() {}

  popular() {}

  Future<List<Initiative>> trending(int numDocs, int seed) async {
    List<Initiative> initiatives = [];
    if (seed != _previousTrendingQuerySeed) {
      _previousTrendingQuerySeed = seed;
      QuerySnapshot querySnapshot =
          await _refStore.orderBy('dateTime').limit(numDocs).get();
      _lastDocFomPreviousQuery =
          querySnapshot.docs[querySnapshot.docs.length - 1];
      querySnapshot.docs.forEach((doc) {
        initiatives.add(Initiative.fromJSON(doc.data()));
      });
    } else {
      QuerySnapshot querySnapshot = await _refStore
          .orderBy('dateTime')
          .startAfterDocument(_lastDocFomPreviousQuery)
          .limit(numDocs)
          .get();
      _lastDocFomPreviousQuery =
          querySnapshot.docs[querySnapshot.docs.length - 1];
      querySnapshot.docs.forEach((doc) {
        initiatives.add(Initiative.fromJSON(doc.data()));
      });
    }
    return initiatives;
  }
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
