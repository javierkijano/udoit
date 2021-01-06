import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
//import 'package:udoit/screens/ProKitLauncher.dart';
import 'package:udoit/utils/AppConstant.dart';

import 'package:udoit/walkthrough/Walkthrough.dart';
import 'package:flutter/services.dart';
import 'package:udoit/utils/AppImages.dart';

class AppSplashScreen extends StatefulWidget {
  static String tag = '/splashScreen';

  @override
  _AppSplashScreenState createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    navigationPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white70,
        child: Column(children: <Widget>[
          Expanded(child: Container()),
          Container(
            //color: Colors.white,
            child: Image.asset(
              logo_text,
              width: MediaQuery.of(context).size.width * 0.6,
              alignment: Alignment.bottomCenter,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          SizedBox(
            child: CircularProgressIndicator(),
            height: MediaQuery.of(context).size.width * 0.3,
            width: MediaQuery.of(context).size.width * 0.3,
          ),
          Expanded(child: Container()),
        ]));
  }
}

void navigationPage(BuildContext context) async {
  await setInt(appOpenCount, (await getInt(appOpenCount)) + 1);

  if (!await isNetworkAvailable()) {
    toastLong(errorInternetNotAvailable);
  }

  await Future.delayed(Duration(seconds: 2));
  WalkThrough().launch(context, isNewTask: true);
}
