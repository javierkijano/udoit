import 'package:flutter/material.dart';
import 'package:udoit/models/firestoreObject.dart';
import 'package:udoit/utils/hash.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:udoit/models/AppGlobals.dart';

class User extends FirestoreObject {
  //firestore fields
  String id;
  String uid;
  String name;
  String email;
  String phoneNumber;
  String _profilePhotoUrl;
  //other fields
  bool loggedIn;
  bool alreadyRequestedToLogIn;
  CachedNetworkImageProvider _profilePhotoImageProvider;

  User({
    this.id,
    this.uid,
    this.name,
    this.email,
    this.phoneNumber,
    profilePhotoUrl,
    this.loggedIn = false,
    this.alreadyRequestedToLogIn = false,
  }) {
    if (profilePhotoUrl != null) this.profilePhotoUrl = profilePhotoUrl;
  }

  set profilePhotoUrl(profilePhotoUrl) {
    this._profilePhotoUrl = profilePhotoUrl;
    this._profilePhotoImageProvider =
        CachedNetworkImageProvider(profilePhotoUrl);
    int a = 0;
  }

  String get profilePhotoUrl {
    return this._profilePhotoUrl;
  }

  CachedNetworkImageProvider get profilePhotoImageProvider {
    return this._profilePhotoImageProvider;
  }

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
