import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/login/Login.dart';
import 'package:udoit/models/initiative.dart';
import 'package:udoit/showInitiatives/ShowInitiativesList.dart';
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
import 'package:udoit/widgets/searchBar.dart';

class Dashboard extends StatefulWidget {
  static String tag = '/Dashboard';

  Dashboard({Key key}) : super(key: key) {}

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
  GlobalKey<ScaffoldState> _scaffoldKey;
  GlobalKey<ListScreenState> _keyListScreen;
  List<String> _filteredCategoriesIds = [];
  Random rand = Random();
  int _randomSeedTrendingQuery;
  //int _randomSeedPopularQuery;
  List<Initiative> trendingInitiatives;

  var selectedIndex = 0;
  var selectedSongType = 0;

  Future<List<IniativesListItem>> iniativesListItemFetcher_trending(
      int start, int end) async {
    List<IniativesListItem> list = <IniativesListItem>[];
    int numDocs = end - start + 1;
    (await Globals.fireManager.downloadTrendingInitiatives(
            numDocs, _randomSeedTrendingQuery,
            categoriesIds: _filteredCategoriesIds))
        .forEach((initiative) {
      list.add(IniativesListItem(initiative: initiative));
    });
    return list;
  }

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _keyListScreen = GlobalKey<ListScreenState>();
    _filteredCategoriesIds =
        Globals.appConf.categories.map((category) => category.id).toList();
    _randomSeedTrendingQuery = rand.nextInt(1000000);
    /*FireManager().downloadTrendingInitiatives(10, 0).then((value) {
      trendingInitiatives = value;
    });*/
  }

  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: 10),
              SearchBar(onTextInputCallback: (text) {
                Navigator.of(context)
                    .pushNamed(ShowInitiatives.tag, arguments: text);
              }),
              Divider(height: 25, thickness: 0.3),
              FilterList(
                  filtersList:
                      Globals.appConf.categories.map((cat) => cat.id).toList(),
                  onFiltersChanged: (filteredCategoriesIds) {
                    setState(() {
                      _filteredCategoriesIds = filteredCategoriesIds;
                      _randomSeedTrendingQuery = rand.nextInt(1000000);
                      _keyListScreen.currentState.resetState();
                    });
                  }),
              Divider(height: 25, thickness: 0.3),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: ListScreen(
                  key: _keyListScreen,
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
