import 'package:udoit/store/AppStore.dart';
import 'package:udoit/models/configuration.dart';
import 'package:udoit/models/initiatives.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class _User {
  bool loggedIn = false;
  String uid;
  String name;
  String email;
  String phoneNumber;
  CachedNetworkImageProvider profileImageProvider;
}

class Globals {
  //static var appStore = AppStore();

  static var fbApp;
  static Configuration appConf = Configuration(version: 'v0.1');
  static Initiatives appInitiatives = Initiatives();
  static var user = _User();
}
