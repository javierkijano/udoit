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
import 'package:udoit/widgets/FilterList.dart';
import 'package:udoit/widgets/bottomNavBar.dart';
import 'package:udoit/models/AppGlobals.dart';
import 'package:udoit/models/fireManager.dart';
import 'package:udoit/widgets/ListScreen.dart';
import 'package:udoit/dashboard/IniativesListItem.dart';
import 'dart:math';

import 'package:udoit/widgets/upNavBar.dart';
import 'package:udoit/gamification/summary.dart';

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
              Divider(height: 25, thickness: 0.3),
              FilterList(
                  filtersNamesList:
                      Globals.appConf.categories.map((cat) => cat.id).toList(),
                  onFiltersChanged: (activeFilters) {
                    activeFilters.forEach((index) {
                      print(Globals.appConf.categories
                          .map((cat) => cat.id)
                          .toList()[index]);
                    });
                  }),

              Divider(height: 25, thickness: 0.3),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: ListScreen(
                  itemFetcher: iniativesListItemFetcher_trending,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Divider(thickness: 0.3, height: 15),
              GamificationSummary(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 0),
      drawer: SideMenu(),
    );
  }
}
