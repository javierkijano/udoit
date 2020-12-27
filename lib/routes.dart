//import 'dart:js';

import 'package:flutter/material.dart';
//import 'package:udoit/main/model/AppModel.dart';
//import 'package:udoit/main/screens/ProKitScreenListing.dart';
import 'package:udoit/main/AppSplashScreen/AppSplashScreen.dart';
import 'package:udoit/main/login_signup/screens/T1Login.dart';
import 'package:udoit/main/dashboard/screens/Dashboard.dart';
import 'package:udoit/main/login_signup/screens/T1Signup.dart';
import 'package:udoit/main/profile/Profile.dart';
import 'package:udoit/main/walkthrough/screens/T4Walkthrough.dart';
import 'package:udoit/main/newSmartMob/NewSmartMob.dart';
import 'package:udoit/main/showInitiatives/ShowInitiatives.dart';

Map<String, WidgetBuilder> routes() {
  return <String, WidgetBuilder>{
    AppSplashScreen.tag: (context) => AppSplashScreen(),
    T4WalkThrough.tag: (context) => T4WalkThrough(),
    T1Login.tag: (context) => T1Login(),
    T1Signup.tag: (context) => T1Signup(),
    Dashboard.tag: (context) => Dashboard(),
    NewSmartMob.tag: (context) => NewSmartMob(),
    Profile.tag: (context) => Profile(),
    ShowInitiatives.tag: (context) => ShowInitiatives()
    //ProKitScreenListing.tag: (context) => ProKitScreenListing(ProTheme()),
  };
}
