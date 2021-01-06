//import 'dart:js';

import 'package:flutter/material.dart';
//import 'package:udoit/model/AppModel.dart';
//import 'package:udoit/screens/ProKitScreenListing.dart';
import 'package:udoit/AppSplashScreen/AppSplashScreen.dart';
import 'package:udoit/login/Login.dart';
import 'package:udoit/dashboard/Dashboard.dart';
import 'package:udoit/login/Signup.dart';
import 'package:udoit/profile/Profile.dart';
import 'package:udoit/walkthrough/Walkthrough.dart';
import 'package:udoit/newSmartMob/NewSmartMob_0.dart';
import 'package:udoit/showInitiatives/ShowInitiativesList.dart';

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
