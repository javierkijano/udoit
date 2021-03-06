import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:udoit/dashboard/Dashboard.dart';
import 'package:udoit/utils/AppStrings.dart';
import 'package:udoit/widgets/AppWidget.dart';
import 'package:udoit/utils/dots_indicator/dots_indicator.dart';
//import 'package:udoit/walkthrough/utils/T4Images.dart';
import 'package:udoit/utils/AppImages.dart';
import 'package:udoit/widgets/Button1.dart';
import 'package:udoit/models/AppGlobals.dart';
import 'package:udoit/utils/AppColors.dart';

import 'package:udoit/login/Login.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/utils/AppColors.dart' as udoitColors;
import 'package:udoit/utils/AppConstant.dart';
import 'package:udoit/widgets/NavigationButtons.dart';

class WalkThrough extends StatefulWidget {
  static var tag = "/WalkThrough";

  @override
  WalkThroughState createState() => WalkThroughState();
}

class WalkThroughState extends State<WalkThrough> {
  int currentIndexPage = 0;
  GlobalKey<NavigationButtonsState> _navigationButtonsStateKey;

  PageController _controller = new PageController();

  @override
  void initState() {
    _navigationButtonsStateKey = GlobalKey();
    currentIndexPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //changeStatusColor(Colors.transparent);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        //fit: StackFit.expand,
        children: <Widget>[
          Image.asset(walkthrough_bg, fit: BoxFit.cover),
          Positioned(
              top: height * 0.025,
              height: height * 0.1,
              child: Image.asset(logo_text)),
          Align(
            alignment: Alignment.bottomCenter,
            //width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height,
            child: PageView(
              controller: _controller,
              children: <Widget>[
                WalkThroughPage(
                    title: walkThrough_t1,
                    description: walkThrough_d1,
                    walkImg: walkthrough_fg),
                WalkThroughPage(
                    title: walkThrough_t2,
                    description: walkThrough_d2,
                    walkImg: walkthrough_fg),
                WalkThroughPage(
                    title: walkThrough_t3,
                    description: walkThrough_d3,
                    walkImg: walkthrough_fg),
              ],
              onPageChanged: (value) async {
                if (await _navigationButtonsStateKey.currentState
                    .setPageIndex(value))
                  setState(() {
                    currentIndexPage = value;
                    print("..onPageChanged.index${value.toString()}");
                  });
              },
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: NavigationButtons(
                key: _navigationButtonsStateKey,
                numPages: 3,
                cancelButtonText: 'Skip',
                onCancelCallback: () async {
                  if (!Globals.appUser.alreadyRequestedToLogIn) {
                    Globals.appUser.alreadyRequestedToLogIn = true;
                    await Navigator.pushNamed(context, Login.tag);
                    Navigator.pushNamed(context, Dashboard.tag);
                  }
                },
                onFinishCallback: () async {
                  if (!Globals.appUser.alreadyRequestedToLogIn) {
                    Globals.appUser.alreadyRequestedToLogIn = true;
                    await Navigator.pushNamed(context, Login.tag);
                    Navigator.pushNamed(context, Dashboard.tag);
                  }
                },
                onNavigateCallback: (pageIndex) async {
                  await _controller.animateToPage(pageIndex,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.linear);
                  setState(() {
                    currentIndexPage = pageIndex;
                    print("...onNavigateIndex${pageIndex.toString()}");
                  });
                },
              )),
        ],
      ),
    );
  }
}

class WalkThroughPage extends StatelessWidget {
  final String title;
  final String description;

  final String walkImg;

  WalkThroughPage({Key key, this.title, this.description, this.walkImg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    //var width = MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomCenter,
      //width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height,
      //child: Column(
      children: <Widget>[
        Column(children: <Widget>[
          SizedBox(height: h * 0.15),
          text(title,
              textColor: appTextColorPrimary,
              fontSize: textSizeNormal,
              fontFamily: fontMedium),
          Padding(
            padding: EdgeInsets.only(left: 28.0, right: 28.0),
            child: text(description,
                fontSize: textSizeMedium, maxLine: 3, isCentered: true),
          ),
        ]),
        CachedNetworkImage(
          fit: BoxFit.fitWidth,
          alignment: Alignment.bottomCenter,
          placeholder: placeholderWidgetFn(),
          imageUrl: walkImg,
        ),
      ],
    );
  }
}
