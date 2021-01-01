import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
//import 'package:udoit/main/screens/ProKitLauncher.dart';
import 'package:udoit/main/utils/AppConstant.dart';

import 'package:udoit/main/walkthrough/Walkthrough.dart';

class AppSplashScreen extends StatefulWidget {
  static String tag = '/ProkitSplashScreen';

  @override
  _AppSplashScreenState createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    navigationPage();
  }

  void navigationPage() async {
    await setInt(appOpenCount, (await getInt(appOpenCount)) + 1);

    if (!await isNetworkAvailable()) {
      toastLong(errorInternetNotAvailable);
    }

    await Future.delayed(Duration(seconds: 1));
    /*
    if (!isMobile) {
      ProKitWebLauncher().launch(context, isNewTask: true);
    } else {
      ProKitLauncher().launch(context, isNewTask: true);
    }
    */
    WalkThrough().launch(context, isNewTask: true);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorFromHex('#FFFDF1'),
      body: Container(
        alignment: Alignment.center,
        //child: Image.asset('images/app/app_icon.png',
        //    height: 200, fit: BoxFit.fitHeight),
        child: Image.asset('assets/splashscreen/splashscreen_2.jpeg'),
      ),
    );
  }
}
