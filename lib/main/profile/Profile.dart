import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/main/widgets/AppWidget.dart';
//import 'package:udoit/theme5/utils/T5BubbleBotoomBar.dart';
//import 'package:udoit/theme5/utils/T5Colors.dart';
import 'package:udoit/main/utils/AppColors.dart';
import 'package:udoit/main/utils/AppConstant.dart';
import 'package:udoit/main/utils/AppProfiles.dart';

import 'package:udoit/main/utils/globals.dart';
import 'package:udoit/main/widgets/bottomNavBar.dart';

//import 'package:udoit/theme5/utils/T5Constant.dart';
//import 'package:udoit/theme5/utils/T5Images.dart';
//import 'package:udoit/theme5/utils/T5Strings.dart';

class Profile extends StatefulWidget {
  static var tag = "/Profile";

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  double width;

  @override
  void initState() {
    super.initState();
  }

  var currentIndex = 0;
  var iconList = <String>["Estadisticas", "Historia", "Favoritos", "Amigos"];
  var nameList = <String>["Estadísticas", "Historia", "Favoritos", "Amigos"];

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget gridItem(int pos) {
    return Container(
        width: (width - (16 * 3)) / 2,
        height: (width - (16 * 3)) / 2,
        decoration:
            boxDecoration(radius: 24, showShadow: true, bgColor: t5White),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              iconList[pos],
              width: width / 7,
              height: width / 7,
              color: black,
            ),
            text(nameList[pos],
                fontSize: textSizeNormal,
                textColor: t5TextColorPrimary,
                fontFamily: fontSemibold)
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(t5DarkNavy);
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: t5LayoutBackgroundWhite,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              height: width,
              color: t5DarkNavy,
              child: Container(
                alignment: Alignment.center,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_left,
                          size: 40, color: t5White),
                      onPressed: () {
                        finish(context);
                      },
                    ),
                    text("Account",
                        textColor: t5White,
                        fontSize: textSizeNormal,
                        fontFamily: fontMedium),
                    Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: SvgPicture.asset("images/theme5/t5_options.svg",
                          width: 25, height: 25, color: t5White),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 80),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    padding: EdgeInsets.only(top: 60),
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        color: t5LayoutBackgroundWhite,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        text(Globals.userName,
                            textColor: t5TextColorPrimary,
                            fontFamily: fontMedium,
                            fontSize: textSizeNormal),
                        text(Globals.userPhoneNumber,
                            fontSize: textSizeLargeMedium),
                        Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  height: 8,
                                  child: LinearProgressIndicator(
                                    value: 0.5, // percent filled
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        t5SkyBlue),
                                    backgroundColor: Color(0XFFD7DCE0),
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  text("Wallet Security",
                                      fontSize: textSizeMedium,
                                      fontFamily: fontSemibold),
                                  text("50%",
                                      textColor: t5SkyBlue,
                                      fontFamily: fontBold,
                                      fontSize: textSizeNormal)
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[gridItem(0), gridItem(1)],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[gridItem(2), gridItem(3)],
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                  CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(profile_1),
                      radius: 50)
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavBar(context, 0),
    );
  }
}
