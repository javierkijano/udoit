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

Future<List<IniativesListItem>> iniativesListItemFetcher_new(
    int start, int end) async {
  List<IniativesListItem> list = <IniativesListItem>[];
  await Future.delayed(Duration(seconds: 1), () {
    for (int i = start; i < end; i++) {
      list.add(IniativesListItem(
          imageUrl:
              'https://firebasestorage.googleapis.com/v0/b/smartmobs-8bebb.appspot.com/o/configuration%2Fcategories%2Fanimales.png?alt=media&token=52279f8d-f8a7-497b-8007-4d32b74f75ac',
          title: 'titulo_$i',
          category: 'titulo_$i',
          date: 'titulo_$i',
          summary: 'titulo_$i',
          index: i));
    }
  });
  return list;
}

Future<List<IniativesListItem>> iniativesListItemFetcher_trend(
    int start, int end) async {
  Globals.appInitiatives.trending(start, after);
  List<IniativesListItem> list = <IniativesListItem>[];
  return list;
}

Future<List<IniativesListItem>> iniativesListItemFetcher_popular(
    int start, int end) async {
  List<IniativesListItem> list = <IniativesListItem>[];
  return list;
}

class ShowInitiatives extends StatefulWidget {
  static var tag = "/ShowInitiatives";

  @override
  ShowInitiativesState createState() => ShowInitiativesState();
}

class ShowInitiativesState extends State<ShowInitiatives> {
  int selectedPos = 1;

  @override
  void initState() {
    super.initState();
    selectedPos = 1;
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
