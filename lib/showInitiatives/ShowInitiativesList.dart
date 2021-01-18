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

class ShowInitiatives extends StatefulWidget {
  static var tag = "/ShowInitiatives";

  @override
  ShowInitiativesState createState() => ShowInitiativesState();
}

class ShowInitiativesState extends State<ShowInitiatives> {
  int selectedPos = 1;
  Random rand = Random();
  int _randomSeedTrendingQuery;
  int _randomSeedPopularQuery;

  Future<List<IniativesListItem>> iniativesListItemFetcher_new(
      int start, int end) async {
    List<IniativesListItem> list = <IniativesListItem>[];
    int numDocs = end - start + 1;
    (await Globals.fireManager.trending(numDocs, _randomSeedTrendingQuery))
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
    (await Globals.fireManager.trending(numDocs, _randomSeedTrendingQuery))
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
    (await Globals.fireManager.trending(numDocs, _randomSeedPopularQuery))
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
          bottom: TabBar(
            onTap: (value) {
              setState(() {
                /*
                switch (value) {
                  case 0:
                    {
                      setState(() {
                        mListings_current = mListings_new;
                      });
                      break;
                    }
                  case 1:
                    {
                      setState(() {
                        mListings_current = mListings_trend;
                      });
                      break;
                    }
                  case 2:
                    {
                      setState(() {
                        mListings_current = mListings_new;
                      });
                      break;
                    }
                }
                */
              });
            },
            tabs: [
              Tab(text: "New"),
              Tab(text: "Trends"),
              Tab(text: "Popular"),
            ],
          ),
        ),
        body: Observer(
            builder: (_) => Container(
                width: MediaQuery.of(context).size.width,
                child: TabBarView(children: <Widget>[
                  ListScreen(itemFetcher: iniativesListItemFetcher_new),
                  ListScreen(itemFetcher: iniativesListItemFetcher_trend),
                  ListScreen(itemFetcher: iniativesListItemFetcher_popular),
                ]))),
      ),
    );
  }
}
