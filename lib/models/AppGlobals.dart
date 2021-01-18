//import 'package:udoit/store/AppStore.dart';
import 'package:udoit/models/configuration.dart';
import 'package:udoit/models/fireManager.dart';
//import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class _User {
  bool loggedIn = false;
  bool alreadyRequestedToLogIn = false;
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
  static FireManager fireManager = FireManager();
  static var user = _User();

  static Future init() async {
    // load global configuration
    await appConf.loadConfiguration();
    user.profileImageProvider =
        CachedNetworkImageProvider(appConf.defaultAvatars['undefined']);
    int a = 0;
  }
}
