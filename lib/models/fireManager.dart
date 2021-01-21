import 'package:udoit/models/configuration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:udoit/utils/gallery_image_picker/generic_gallery_image_picker.dart';

import 'dart:async';
import 'package:udoit/models/initiative.dart';
import 'package:udoit/models/comment.dart';

//TODO: confusing that we have a initiatives class and then we use initiatives list in other part of the code. Better change name for iniativesManager or similar
class FireManager {
  CollectionReference _refStoreInitiatives;
  CollectionReference _refStoreComments;
  CollectionReference _refStoreUsers;
  firebase_storage.Reference _refStorageInitiatives;

  int _previousTrendingInitiativesQuerySeed;
  QueryDocumentSnapshot _lastTrendingInitiativesDocFomPreviousQuery;
  int _previousInitiativeCommentsQuerySeed;
  QueryDocumentSnapshot _lastInitiativeCommentsDocFomPreviousQuery;

  FireManager() {
    _refStoreInitiatives = FirebaseFirestore.instance.collection('initiatives');
    _refStoreComments = FirebaseFirestore.instance.collection('comments');
    _refStoreUsers = FirebaseFirestore.instance.collection('users');
    _refStorageInitiatives =
        firebase_storage.FirebaseStorage.instance.ref().child('initiatives');
  }

  Future uploadInitiativeToFirestore(Initiative initiative) async {
    List<Future<firebase_storage.TaskSnapshot>> _uploadTasks = [];

    for (Map<String, dynamic> uint8image in initiative.uint8images) {
      final metadata = firebase_storage.SettableMetadata(
          contentType: 'image/${uint8image['name'].split(".").last}',
          customMetadata: {'test': 'hola'});
      _uploadTasks.add(_refStorageInitiatives
          .child(initiative.id)
          .child(uint8image['name'])
          .putData(uint8image['data'], metadata)
          .whenComplete(() {
        int a = 0;
      }).catchError((onError) {
        print('... ERROR uploading to firebase storage: $onError');
      }));
    }
  }

  Future<List<Initiative>> downloadTrendingInitiatives(
      int numDocs, int seed) async {
    List<Initiative> initiatives = [];
    if (seed != _previousTrendingInitiativesQuerySeed) {
      _previousTrendingInitiativesQuerySeed = seed;
      QuerySnapshot querySnapshot = await _refStoreInitiatives
          .orderBy('dateTime', descending: true)
          .limit(numDocs)
          .get();
      if (querySnapshot.docs.length > 0)
        _lastTrendingInitiativesDocFomPreviousQuery =
            querySnapshot.docs[querySnapshot.docs.length - 1];
      querySnapshot.docs.forEach((doc) {
        initiatives.add(Initiative()..fromFirestoreDoc(doc));
      });
    } else {
      QuerySnapshot querySnapshot = await _refStoreInitiatives
          .orderBy('dateTime', descending: true)
          .startAfterDocument(_lastTrendingInitiativesDocFomPreviousQuery)
          .limit(numDocs)
          .get();
      if (querySnapshot.docs.length > 0)
        _lastTrendingInitiativesDocFomPreviousQuery =
            querySnapshot.docs[querySnapshot.docs.length - 1];
      querySnapshot.docs.forEach((doc) {
        initiatives.add(Initiative()..fromFirestoreDoc(doc));
      });
    }
    return initiatives;
  }

  Future uploadCommentToFirestore(String initiativeId, Comment comment) async {
    await _refStoreInitiatives
        .doc(initiativeId)
        .collection('comments')
        .add(comment.asFirestoreData())
        .then((value) => null)
        .catchError((onError) {
      print('... ERROR uploading to firestore: $onError');
    });
  }

  Future<List<Comment>> downloadInitiativeComments(
      String iniativeID, int numDocs, int seed) async {
    List<Comment> comments = [];
    if (seed != _previousInitiativeCommentsQuerySeed) {
      _previousInitiativeCommentsQuerySeed = seed;
      QuerySnapshot querySnapshot = await _refStoreComments
          .orderBy('dateTime', descending: true)
          .limit(numDocs)
          .get();
      if (querySnapshot.docs.length > 0)
        _lastTrendingInitiativesDocFomPreviousQuery =
            querySnapshot.docs[querySnapshot.docs.length - 1];
      querySnapshot.docs.forEach((doc) {
        comments.add(Comment()..fromFirestoreDoc(doc));
      });
    } else {
      QuerySnapshot querySnapshot = await _refStoreComments
          .orderBy('dateTime', descending: true)
          .startAfterDocument(_lastInitiativeCommentsDocFomPreviousQuery)
          .limit(numDocs)
          .get();
      if (querySnapshot.docs.length > 0)
        _lastTrendingInitiativesDocFomPreviousQuery =
            querySnapshot.docs[querySnapshot.docs.length - 1];
      querySnapshot.docs.forEach((doc) {
        comments.add(Comment()..fromFirestoreDoc(doc));
      });
    }
    return comments;
  }
}
