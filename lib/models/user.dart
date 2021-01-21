import 'package:flutter/material.dart';
import 'package:udoit/models/firestoreObject.dart';
import 'package:udoit/utils/hash.dart';
import 'package:cached_network_image/cached_network_image.dart';

class User extends FirestoreObject {
  //firestore fields
  String id;
  String uid;
  String name;
  String email;
  String phoneNumber;
  String profilePhotoUrl;
  //other fields
  bool loggedIn;
  bool alreadyRequestedToLogIn;
  CachedNetworkImageProvider profileImageProvider;

  User({
    this.id,
    this.uid,
    this.name,
    this.email,
    this.phoneNumber,
    this.profilePhotoUrl,
    this.loggedIn = false,
    this.alreadyRequestedToLogIn = false,
  });

  @override
  void fromFirestoreDoc(dynamic doc) {
    Map<String, dynamic> data = doc.data();
    this.id = doc.id;
    this.uid = doc.uid;
    this.name = doc.name;
    this.email = doc.email;
    this.phoneNumber = doc.phoneNumber;
    this.profilePhotoUrl = doc.profilePhoto;
  }

  @override
  Map<String, dynamic> asFirestoreData() {
    return {
      'uid': this.uid,
      'name': this.name,
      'email': this.email,
      'phoneNumber': this.phoneNumber,
      'profilePhotoUrl': this.profilePhotoUrl,
    };
  }
}
