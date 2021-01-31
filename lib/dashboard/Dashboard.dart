import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/login/Login.dart';
import 'package:udoit/models/initiative.dart';
import 'package:udoit/widgets/AppWidget.dart';
import 'package:udoit/dashboard/T11Models.dart';
import 'package:udoit/utils/AppConstant.dart';

import 'package:udoit/dashboard/T11DataGenerator.dart';
//import 'package:udoit/dashboard/utils/T11Images.dart';
import 'package:udoit/utils/AppColors.dart';

import 'package:udoit/newInitiative/NewInitiative.dart';

import 'package:udoit/sideMenu/sideMenu.dart';
import 'package:udoit/widgets/bottomNavBar.dart';
import 'package:udoit/models/AppGlobals.dart';
import 'package:udoit/models/fireManager.dart';
import 'package:udoit/widgets/ListScreen.dart';
import 'package:udoit/dashboard/IniativesListItem.dart';
import 'dart:math';

import 'package:udoit/widgets/upNavBar.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Dashboard extends StatefulWidget {
  static String tag = '/Dashboard';

  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();

  static _DashboardState of(BuildContext context) {
    final _DashboardState result =
        context.findAncestorStateOfType<_DashboardState>();
    assert(result != null);
    return result;
  }
}

class _DashboardState extends State<Dashboard> {
  Random rand = Random();
  int _randomSeedTrendingQuery;
  int _randomSeedPopularQuery;
  List<Initiative> trendingInitiatives;

  List<Theme11SongType> mList1;
  List<Theme11SongsList> mList2;

  var selectedIndex = 0;
  var selectedSongType = 0;

  Future<List<IniativesListItem>> iniativesListItemFetcher_trending(
      int start, int end) async {
    List<IniativesListItem> list = <IniativesListItem>[];
    int numDocs = end - start + 1;
    (await Globals.fireManager
            .downloadTrendingInitiatives(numDocs, _randomSeedTrendingQuery))
        .forEach((element) {
      list.add(IniativesListItem(
          imageUrl: element.imagesUrls[0],
          title: element.title,
          category: element.category.id.toString(),
          date: element.dateTime.toString(),
          summary: element.summary));
    });
    return list;
  }

  @override
  void initState() {
    super.initState();
    _randomSeedTrendingQuery = rand.nextInt(1000000);
    FireManager().downloadTrendingInitiatives(10, 0).then((value) {
      trendingInitiatives = value;
    });
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
      appBar: UpNavBar(),
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
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: ListScreen(
                  itemFetcher: iniativesListItemFetcher_trending,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Divider(thickness: 0.3, height: 15),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(30),
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              return CachedNetworkImage(
                                  width: constraints.maxWidth * 0.8,
                                  imageUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/smartmobs-8bebb.appspot.com/o/gamification_levels%2Flevels%2Fprotester.png?alt=media&token=45d5791b-b614-4026-bf5c-4e3340c1e8dc');
                            }),
                          ),
                          VerticalDivider(thickness: 0.5),
                          Expanded(
                            flex: 4,
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              return CircularPercentIndicator(
                                radius: constraints.maxWidth * 1,
                                lineWidth: 25.0,
                                animation: true,
                                percent: 0.7,
                                center: new Text(
                                  "70.0%",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40.0),
                                ),
                                /*footer: new Text(
                                  "Sales this week",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ),*/
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: Colors.purple,
                              );
                            }),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                                padding: EdgeInsets.only(top: 15),
                                child: Text(
                                  'Level: Rookie',
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                )),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                                padding: EdgeInsets.only(top: 15),
                                child: Text(
                                  'Level Achievements',
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 0),
      drawer: SideMenu(),
    );
  }
}
