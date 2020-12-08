import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:udoit/main/dashboard/screens/Dashboard.dart';
import 'package:udoit/main/utils/AppStrings.dart';
import 'package:udoit/main/widgets/AppWidget.dart';
import 'package:udoit/main/utils/dots_indicator/dots_indicator.dart';
import 'package:udoit/main/walkthrough/utils/T4Colors.dart';
import 'package:udoit/main/walkthrough/utils/T4Constant.dart';
//import 'package:udoit/main/walkthrough/utils/T4Images.dart';
import 'package:udoit/main/utils/AppImages.dart';
import 'package:udoit/main/walkthrough/utils/widgets/T4Button.dart';
import 'package:udoit/main/utils/globals.dart';

import 'package:udoit/main/login_signup/screens/T1Login.dart';
import 'package:udoit/main/login_signup/model/T1_model.dart';
import 'package:nb_utils/nb_utils.dart';

class T4WalkThrough extends StatefulWidget {
  static var tag = "/T4WalkThrough";

  @override
  T4WalkThroughState createState() => T4WalkThroughState();
}

class T4WalkThroughState extends State<T4WalkThrough> {
  int currentIndexPage = 0;

  PageController _controller = new PageController();

  @override
  void initState() {
    super.initState();
    currentIndexPage = 0;
  }

  VoidCallback onPrev() {
    setState(() {
      if (currentIndexPage >= 1) {
        currentIndexPage = currentIndexPage - 1;
        _controller.jumpToPage(currentIndexPage);
      }
    });
  }

  VoidCallback onSkip() {
    setState(() {
      //T4WalkThrough().launch(context, isNewTask: true);
      Navigator.pushNamed(context, T1Login.tag,
          arguments: LoginRoutes("/Dashboard"));
    });
  }

  VoidCallback onNext() {
    setState(() {
      if (currentIndexPage < 2) {
        currentIndexPage = currentIndexPage + 1;
        _controller.jumpToPage(currentIndexPage);
      } else {
        if (!Globals.loggedIn) {
          Navigator.pushNamed(context, T1Login.tag,
              arguments: LoginRoutes(Dashboard.tag));
        } else
          Navigator.pushNamed(context, Dashboard.tag);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.transparent);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        //fit: StackFit.expand,
        children: <Widget>[
          Align(
              alignment: Alignment.bottomCenter,
              child: OverflowBox(
                maxHeight: double.infinity,
                alignment: Alignment.bottomCenter,
                child: Image.asset(walkthrough_bg, fit: BoxFit.fitWidth),
              )),
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
                WalkThrough(
                    title: walkThrough_t1,
                    description: walkThrough_d1,
                    walkImg: walkthrough_fg),
                WalkThrough(
                    title: walkThrough_t2,
                    description: walkThrough_d2,
                    walkImg: walkthrough_fg),
                WalkThrough(
                    title: walkThrough_t3,
                    description: walkThrough_d3,
                    walkImg: walkthrough_fg),
              ],
              onPageChanged: (value) {
                setState(() => currentIndexPage = value);
              },
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
                      dotsCount: 3,
                      position: currentIndexPage,
                      decorator: DotsDecorator(
                        color: t4_view_color,
                        activeColor: t4_colorPrimary,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      T4Button(
                        textContent: "Skip",
                        onPressed: onSkip,
                        isStroked: true,
                      ),
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
          ),
        ],
      ),
    );
  }
}

class WalkThrough extends StatelessWidget {
  final String title;
  final String description;

  final String walkImg;

  WalkThrough({Key key, this.title, this.description, this.walkImg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
              textColor: Globals.appStore.textPrimaryColor,
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
