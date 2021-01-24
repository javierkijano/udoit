import 'package:udoit/models/AppGlobals.dart';
import 'package:udoit/utils/AppIcons.dart';
import 'package:udoit/utils/AppColors.dart';
import 'package:udoit/utils/AppProfiles.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';

class SideMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SideMenuState();
  }
}

class SideMenuState extends State<SideMenu> {
  var selectedItem = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height,
      child: Observer(
        builder: (_) => Drawer(
          elevation: 8,
          child: Container(
            color: scaffoldBackground,
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: scaffoldBackground,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 70, right: 20),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                        decoration: BoxDecoration(
                            color: t2_colorPrimary,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(24.0),
                                topRight: Radius.circular(24.0))),
                        //User Profile
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                                backgroundImage:
                                    Globals.appUser.profilePhotoImageProvider,
                                radius: 40),
                            SizedBox(width: 16),
                            if (Globals.loggedIn)
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(Globals.appUser.name,
                                          style: boldTextStyle(
                                              color: white, size: 20)),
                                      SizedBox(height: 8),
                                      Text(Globals.appUser.email,
                                          style:
                                              primaryTextStyle(color: white)),
                                    ],
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    getDrawerItem(Icons.person, Colors.black, "Profile", 1),
                    getDrawerItem(Icons.chat, Colors.black, "Message", 2),
                    getDrawerItem(Icons.report, Colors.black, "Report", 3),
                    getDrawerItem(Icons.settings, Colors.black, "Settings", 4),
                    getDrawerItem(Icons.logout, Colors.black, "Sign Out", 5),
                    SizedBox(height: 30),
                    Divider(color: t2_view_color, height: 1),
                    SizedBox(height: 30),
                    getDrawerItem(
                        Icons.share, Colors.black, "Share and invite", 6),
                    getDrawerItem(
                        Icons.help, Colors.black, "Help and feedback", 7),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    int a = 0;
  }

  Widget getDrawerItem(
      IconData iconData, Color iconColor, String name, int pos) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = pos;
        });
      },
      child: Container(
        color: selectedItem == pos ? t2_colorPrimaryLight : scaffoldBackground,
        padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: Row(
          children: <Widget>[
            /*
            SvgPicture.asset(
              icon,
              width: 24,
              height: 24,
              color: Globals.appStore.iconColor,
            ),*/
            Icon(
              iconData,
              color: iconColor,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            SizedBox(width: 20),
            Text(name,
                style: primaryTextStyle(
                    color: selectedItem == pos
                        ? t2_colorPrimary
                        : textPrimaryColor,
                    size: 18))
          ],
        ),
      ),
    );
  }
}
