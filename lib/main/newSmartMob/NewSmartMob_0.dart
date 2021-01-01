import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:udoit/main/widgets/AppWidget.dart';
import 'package:udoit/main/utils/dots_indicator/dots_indicator.dart';
import 'package:udoit/main/walkthrough/utils/T4Colors.dart';
import 'package:udoit/main/walkthrough/utils/T4Constant.dart';
import 'package:udoit/main/walkthrough/utils/T4Images.dart';
import 'package:udoit/main/walkthrough/utils/widgets/T4Button.dart';
import 'package:udoit/main/utils/AppGlobals.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/main/newSmartMob/NewSmartMob_1.dart';
import 'package:udoit/main/newSmartMob/NewSmartMob_2.dart';
import 'package:udoit/main/newSmartMob/NewSmartMob_3.dart';
import 'package:udoit/main/newSmartMob/NewSmartMob_4.dart';
import 'package:udoit/main/newSmartMob/NewSmartMob_5.dart';
import 'package:udoit/main/newSmartMob/NewSmartMob_6.dart';

//import 'package:udoit/main/newSmartMob/models/NewSmartMobModel.dart';
import 'package:udoit/main/login/T1_model.dart';
import 'package:udoit/main/login/T1Login.dart';
import 'package:udoit/main/models/initiatives.dart';

class NewSmartMob extends StatefulWidget {
  static var tag = "/NewSmartMob";

  @override
  NewSmartMobState createState() => NewSmartMobState();
}

class NewSmartMobState extends State<NewSmartMob> {
  int currentIndexPage = 0;

  //ewSmartMobData newSmartMobData = NewSmartMobData();

  PageController _controller = new PageController();

  GlobalKey<NewSmartMob1State> _keyNewSmartMob1State = GlobalKey();
  GlobalKey<NewSmartMob2State> _keyNewSmartMob2State = GlobalKey();
  GlobalKey<NewSmartMob3State> _keyNewSmartMob3State = GlobalKey();
  GlobalKey<NewSmartMob4State> _keyNewSmartMob4State = GlobalKey();
  GlobalKey<NewSmartMob5State> _keyNewSmartMob5State = GlobalKey();
  GlobalKey<NewSmartMob6State> _keyNewSmartMob6State = GlobalKey();

  NewSmartMob1 newSmartMob1;
  NewSmartMob2 newSmartMob2;
  NewSmartMob3 newSmartMob3;
  NewSmartMob4 newSmartMob4;
  NewSmartMob5 newSmartMob5;
  NewSmartMob6 newSmartMob6;

  Initiative initiative;

  DateTime _initiativeDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    currentIndexPage = 0;

    // TODO: remove this
    Globals.user.loggedIn = false;

    newSmartMob1 = NewSmartMob1(key: _keyNewSmartMob1State);
    newSmartMob2 = NewSmartMob2(key: _keyNewSmartMob2State);
    newSmartMob3 = NewSmartMob3(key: _keyNewSmartMob3State);
    newSmartMob4 = NewSmartMob4(key: _keyNewSmartMob4State);
    newSmartMob5 = NewSmartMob5(key: _keyNewSmartMob5State);
    newSmartMob6 = NewSmartMob6(key: _keyNewSmartMob6State);
  }

  VoidCallback onPrev() {
    setState(() => currentIndexPage = currentIndexPage - 1);
    _controller.jumpToPage(currentIndexPage);
  }

  VoidCallback onNext() {
    setState(() => currentIndexPage = currentIndexPage + 1);
    _controller.jumpToPage(currentIndexPage);
  }

  void _onPageChanged(value) {
    setState(() => currentIndexPage = value);
    if (currentIndexPage == 4 && !Globals.user.loggedIn) {
      Navigator.pushNamed(context, T1Login.tag,
          arguments: LoginRoutes("/NewSmartMob"));
    }
    if (currentIndexPage == 5) {
      Globals.appInitiatives.add(Initiative(
          dateTime: _initiativeDateTime,
          category: _keyNewSmartMob1State.currentState.category,
          title: _keyNewSmartMob2State.currentState.title,
          destinatary: _keyNewSmartMob3State.currentState.destinatary,
          request: _keyNewSmartMob4State.currentState.request,
          uint8images: _keyNewSmartMob5State.currentState.uint8images,
          youtubeVideoUrl: _keyNewSmartMob5State.currentState.videoUrl));
      int a = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.transparent);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(t4_walk_bg,
              width: width * 0.8, height: height * 0.5, fit: BoxFit.fill),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: PageView(
              controller: _controller,
              children: <Widget>[
                NewSmartMob1(key: _keyNewSmartMob1State),
                NewSmartMob2(key: _keyNewSmartMob2State),
                NewSmartMob3(key: _keyNewSmartMob3State),
                NewSmartMob4(key: _keyNewSmartMob4State),
                NewSmartMob5(key: _keyNewSmartMob5State),
                NewSmartMob6(key: _keyNewSmartMob6State),
              ],
              onPageChanged: _onPageChanged,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                      child: T4Button(
                          textContent: "Prev",
                          onPressed: onPrev,
                          isStroked: false)),
                  DotsIndicator(
                      dotsCount: 6,
                      position: currentIndexPage,
                      decorator: DotsDecorator(
                        size: const Size.fromRadius(5.0),
                        activeSize: const Size.fromRadius(10.0),
                        color: t4_view_color,
                        activeColor: t4_colorPrimary,
                        spacing: const EdgeInsets.all(5.0),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      /*
                      T4Button(
                        textContent: "Skip",
                        onPressed: onSkip,
                        isStroked: true,
                      ),*/
                      T4Button(
                        textContent: "Next",
                        onPressed: onNext,
                        isStroked: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
