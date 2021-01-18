import 'package:udoit/models/configuration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:udoit/utils/gallery_image_picker/generic_gallery_image_picker.dart';

import 'dart:async';
import 'package:udoit/models/initiative.dart';

//TODO: confusing that we have a initiatives class and then we use initiatives list in other part of the code. Better change name for iniativesManager or similar
class FireManager {
  CollectionReference _refStore;
  firebase_storage.Reference _refStorage;
  int _previousTrendingQuerySeed;
  QueryDocumentSnapshot _lastDocFomPreviousQuery;

  FireManager() {
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

/*
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
  */

  Future<List<Initiative>> trending(int numDocs, int seed) async {
    List<Initiative> initiatives = [];
    if (seed != _previousTrendingQuerySeed) {
      _previousTrendingQuerySeed = seed;
      QuerySnapshot querySnapshot = await _refStore
          .orderBy('dateTime', descending: true)
          .limit(numDocs)
          .get();
      if (querySnapshot.docs.length > 0)
        _lastDocFomPreviousQuery =
            querySnapshot.docs[querySnapshot.docs.length - 1];
      querySnapshot.docs.forEach((doc) {
        initiatives.add(Initiative.fromJSON(doc.data()));
      });
    } else {
      QuerySnapshot querySnapshot = await _refStore
          .orderBy('dateTime', descending: true)
          .startAfterDocument(_lastDocFomPreviousQuery)
          .limit(numDocs)
          .get();
      if (querySnapshot.docs.length > 0)
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
