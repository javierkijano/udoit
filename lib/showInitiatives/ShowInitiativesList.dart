import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
//import 'package:prokit_flutter/main.dart';
import 'package:udoit/widgets/AppWidget.dart';
import 'package:udoit/utils/AppColors.dart';
import 'package:udoit/utils/AppStrings.dart';
import 'package:udoit/models/AppGlobals.dart';
import 'package:udoit/widgets/ListScreen.dart';
import 'IniativesListItem.dart';
import 'dart:math';
import 'package:udoit/models/fireManager.dart';
import 'package:udoit/widgets/searchBar.dart';

class ShowInitiatives extends StatefulWidget {
  static var tag = "/ShowInitiatives";

  ShowInitiatives({Key key, String initialSearchBarText}) : super(key: key) {
    //initialSearchBarText
  }

  @override
  ShowInitiativesState createState() => ShowInitiativesState();
}

class ShowInitiativesState extends State<ShowInitiatives> {
  int selectedPos = 1;
  Random rand = Random();
  int _randomSeedTrendingQuery;
  int _randomSeedPopularQuery;
  List<String> _filteredCategoriesIds = [];

  Future<List<IniativesListItem>> iniativesListItemFetcher_new(
      int start, int end) async {
    List<IniativesListItem> list = <IniativesListItem>[];
    int numDocs = end - start + 1;
    (await Globals.fireManager.downloadTrendingInitiatives(
            numDocs, _randomSeedTrendingQuery,
            categoriesIds: _filteredCategoriesIds))
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

  Future<List<IniativesListItem>> iniativesListItemFetcher_trend(
      int start, int end) async {
    List<IniativesListItem> list = <IniativesListItem>[];
    int numDocs = end - start + 1;
    (await Globals.fireManager.downloadTrendingInitiatives(
            numDocs, _randomSeedTrendingQuery,
            categoriesIds: _filteredCategoriesIds))
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

  Future<List<IniativesListItem>> iniativesListItemFetcher_popular(
      int start, int end) async {
    List<IniativesListItem> list = <IniativesListItem>[];
    int numDocs = end - start + 1;
    (await Globals.fireManager.downloadTrendingInitiatives(
            numDocs, _randomSeedPopularQuery,
            categoriesIds: _filteredCategoriesIds))
        .forEach((element) {
      list.add(IniativesListItem(
          imageUrl: element.imagesUrls[0],
          title: element.title,
          category: element.category.toString(),
          date: element.dateTime.toString(),
          summary: element.summary));
    });
    return list;
  }

  @override
  void initState() {
    super.initState();
    _filteredCategoriesIds =
        Globals.appConf.categories.map((category) => category.id).toList();
    selectedPos = 1;
    _randomSeedTrendingQuery = rand.nextInt(1000000);
  }

  @override
  Widget build(BuildContext context) {
    //var width = MediaQuery.of(context).size.width;
    //changeStatusColor(appBarColor);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: app_gradientColor2,
          title: SearchBar(
                  initialText: ModalRoute.of(context).settings.arguments,
                  autofocus: true)
              .paddingTop(15),
          bottom: TabBar(
            indicatorColor: Colors.blue,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.white,
            onTap: (value) {},
            tabs: [
              Tab(text: "New"),
              Tab(text: "Trends"),
              Tab(text: "Popular"),
            ],
          ),
        ),
        body: Observer(
          builder: (_) => Container(
            color: app_gradientColor2,
            child: Column(children: [
              SizedBox(height: 15),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    ListScreen(itemFetcher: iniativesListItemFetcher_new),
                    ListScreen(itemFetcher: iniativesListItemFetcher_trend),
                    ListScreen(itemFetcher: iniativesListItemFetcher_popular),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
