//import 'package:udoit/store/AppStore.dart';
import 'package:udoit/models/configuration.dart';
import 'package:udoit/models/fireManager.dart';
//import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:udoit/models/user.dart';

class Globals {
  //static var appStore = AppStore();
  static bool loggedIn = false;
  static Configuration appConf = Configuration(version: 'v0.1');
  static FireManager fireManager = FireManager();
  static User appUser;

  static Future init() async {
    // load global configuration
    await appConf.loadConfiguration();
    Globals.appUser =
        User(profilePhotoUrl: appConf.defaultAvatars['undefined']);
    int a = 0;
  }
}
