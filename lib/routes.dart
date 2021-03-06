//import 'dart:js';

import 'dart:js';

import 'package:flutter/material.dart';
//import 'package:udoit/model/AppModel.dart';
//import 'package:udoit/screens/ProKitScreenListing.dart';
import 'package:udoit/AppSplashScreen/AppSplashScreen.dart';
import 'package:udoit/login/Login.dart';
import 'package:udoit/dashboard/Dashboard.dart';
import 'package:udoit/login/Signup.dart';
import 'package:udoit/models/initiative.dart';
import 'package:udoit/profile/Profile.dart';
import 'package:udoit/walkthrough/Walkthrough.dart';
import 'package:udoit/newInitiative/NewInitiative.dart';
import 'package:udoit/showInitiatives/ShowInitiativesList.dart';
import 'package:udoit/description/description.dart';

Map<String, WidgetBuilder> routes() {
  return <String, WidgetBuilder>{
    AppSplashScreen.tag: (context) => AppSplashScreen(),
    WalkThrough.tag: (context) => WalkThrough(),
    Login.tag: (context) => Login(),
    Signup.tag: (context) => Signup(),
    Dashboard.tag: (context) => Dashboard(),
    NewInitiative.tag: (context) => NewInitiative(),
    Profile.tag: (context) => Profile(),
    ShowInitiatives.tag: (context) => ShowInitiatives(),
    Description.tag: (context) => Description(),
    //ShareTest.tag: (context) => ShareTest(),
    //ProKitScreenListing.tag: (context) => ProKitScreenListing(ProTheme()),
  };
}
