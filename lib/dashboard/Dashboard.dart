import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/widgets/AppWidget.dart';
import 'package:udoit/dashboard/T11Models.dart';
import 'package:udoit/utils/AppConstant.dart';

import 'package:udoit/dashboard/T11DataGenerator.dart';
//import 'package:udoit/dashboard/utils/T11Images.dart';
import 'package:udoit/utils/AppColors.dart';

import 'package:udoit/newSmartMob/NewSmartMob_0.dart';

import 'package:udoit/sideMenu/sideMenu.dart';
import 'package:udoit/widgets/bottomNavBar.dart';

class Dashboard extends StatefulWidget {
  static String tag = '/Dashboard';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Theme11SongType> mList1;
  List<Theme11SongsList> mList2;

  var selectedIndex = 0;
  var selectedSongType = 0;

  @override
  void initState() {
    super.initState();
    mList1 = theme11songTypeList();
    mList2 = theme11SongList();
  }

  @override
  Widget build(BuildContext context) {
    final searchView = Container(
      height: 80,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          filled: true,
          fillColor: whiteColor,
          hintText: "Busca una iniciativa",
          border: InputBorder.none,
          suffixIcon: Icon(Icons.search, color: appColorPrimary).paddingAll(16),
          contentPadding:
              EdgeInsets.only(left: 16.0, bottom: 8.0, top: 8.0, right: 16.0),
        ),
      ).cornerRadiusWithClipRRect(20),
      alignment: Alignment.center,
    ).cornerRadiusWithClipRRect(10).paddingAll(16);

    /*
    final songDetail = Row(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: t11_ic_Music1,
          height: 80,
          width: 80,
          fit: BoxFit.fill,
        ).cornerRadiusWithClipRRect(20).paddingAll(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              text(t11_lbl_song_of_day,
                      fontSize: textSizeLargeMedium,
                      textColor: t11_blackColor,
                      fontFamily: fontMedium)
                  .paddingOnly(right: 16),
              text(t11_lbl_SmokeMirrors,
                      textColor: udoit_Colors.appColorPrimary,
                      fontSize: textSizeNormal,
                      fontFamily: fontMedium)
                  .paddingOnly(top: 4, right: 16, bottom: 16),
            ],
          ),
        ),
        Container(
          height: 50,
          width: 50,
          color: udoit_Colors.appColorPrimary.withOpacity(0.2),
        ).cornerRadiusWithClipRRect(25).paddingAll(16)
      ],
    );*/

    final songType = Container(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: mList1.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            color: selectedSongType == index ? appColorPrimary : whiteColor,
            child: text(
              mList1[index].name,
              textColor:
                  selectedSongType == index ? whiteColor : appColorPrimary,
              fontSize: textSizeLargeMedium,
              fontFamily: fontRegular,
            ).paddingOnly(left: 16, right: 20).center(),
          )
              .cornerRadiusWithClipRRect(25)
              .paddingOnly(left: 16, right: 8, top: 16, bottom: 16)
              .onTap(() {
            setState(() {
              selectedSongType = index;
            });
          });
        },
      ),
    );

    final songList = Container(
      height: 420,
      child: ListView.builder(
        itemCount: mList2.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Builder(
                    builder: (context) {
                      if (mList2[index].img.contains('http'))
                        return CachedNetworkImage(
                          imageUrl: mList2[index].img,
                          fit: BoxFit.fill,
                        ).cornerRadiusWithClipRRect(20).paddingTop(16);
                      else
                        return Image.asset(
                          mList2[index].img,
                          fit: BoxFit.fill,
                        ).cornerRadiusWithClipRRect(20).paddingTop(16);
                    },
                  )),
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width / 1.5,
                color: blackColor.withOpacity(0.7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    text(
                      mList2[index].title,
                      textColor: whiteColor,
                      fontSize: textSizeNormal,
                      fontFamily: fontBold,
                    ),
                    text(mList2[index].subtitle,
                            textColor: whiteColor,
                            fontSize: textSizeMedium,
                            fontFamily: fontRegular)
                        .paddingTop(4),
                  ],
                ).paddingAll(16),
              ).cornerRadiusWithClipRRect(20)
            ],
          ).paddingAll(16);
        },
      ),
    );
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //backgroundColor: grocery_colorPrimary,
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        _scaffoldKey.currentState.openDrawer();
                      }),
                  SizedBox(width: spacing_large),
                  text("Store",
                      textColor: appWhite,
                      fontFamily: fontBold,
                      fontSize: textSizeLargeMedium),
                ],
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    child: Icon(Icons.add),
                    onTap: () {
                      NewSmartMob().launch(context);
                    },
                  ),
                  SizedBox(width: spacing_standard_new),
                  GestureDetector(
                    child: Icon(Icons.search),
                    onTap: () {
                      NewSmartMob().launch(context);
                    },
                  ),
                  SizedBox(width: spacing_standard_new),
                  GestureDetector(
                    child: Icon(Icons.notifications),
                    onTap: () {
                      //GroceryNotification().launch(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        /*
        bottom: TabBar(
          indicatorColor: grocery_color_white,
          tabs: [
            Tab(
                icon: Image.asset(grocery_ic_shop,
                    color: grocery_color_white, height: 20, width: 20)),
            Tab(icon: Icon(Icons.shopping_basket)),
            Tab(
                icon: Image.asset(grocery_ic_outline_favourite,
                    color: grocery_color_white, height: 20, width: 20)),
            Tab(
                icon: Image.asset(Grocery_ic_User,
                    color: grocery_color_white, height: 20, width: 20))
          ],
        ),*/
      ),
      body: Container(
        color: app_gradientColor2,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30),
              searchView,
              //songDetail,
              Divider(height: 25),
              songType,
              songList,
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavBar(context, 0),
      drawer: SideMenu(),
    );
  }
}
