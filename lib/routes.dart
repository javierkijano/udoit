//import 'dart:js';

import 'package:flutter/material.dart';
//import 'package:udoit/main/model/AppModel.dart';
//import 'package:udoit/main/screens/ProKitScreenListing.dart';
import 'package:udoit/main/AppSplashScreen/AppSplashScreen.dart';
import 'package:udoit/main/login/Login.dart';
import 'package:udoit/main/dashboard/Dashboard.dart';
import 'package:udoit/main/login/Signup.dart';
import 'package:udoit/main/profile/Profile.dart';
import 'package:udoit/main/walkthrough/Walkthrough.dart';
import 'package:udoit/main/newSmartMob/NewSmartMob_0.dart';
import 'package:udoit/main/showInitiatives/ShowInitiatives.dart';

Map<String, WidgetBuilder> routes() {
  return <String, WidgetBuilder>{
    AppSplashScreen.tag: (context) => AppSplashScreen(),
    WalkThrough.tag: (context) => WalkThrough(),
    Login.tag: (context) => Login(),
    Signup.tag: (context) => Signup(),
    Dashboard.tag: (context) => Dashboard(),
    NewSmartMob.tag: (context) => NewSmartMob(),
    Profile.tag: (context) => Profile(),
    ShowInitiatives.tag: (context) => ShowInitiatives()
    //ProKitScreenListing.tag: (context) => ProKitScreenListing(ProTheme()),
  };
}
