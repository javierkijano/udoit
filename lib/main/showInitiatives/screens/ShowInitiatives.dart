import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
//import 'package:prokit_flutter/main.dart';
import 'package:udoit/main/widgets/AppWidget.dart';
import 'package:udoit/main/showInitiatives/models/models.dart';
import 'package:udoit/main/utils/AppColors.dart';
//import 'package:prokit_flutter/theme2/utils/T2DataGenerator.dart';
import 'package:udoit/main/utils/AppStrings.dart';
import 'package:udoit/main/utils/globals.dart';
import 'package:udoit/main/showInitiatives/models/models.dart';
import 'package:udoit/main/widgets/ListInitiatives.dart';

class ShowInitiatives extends StatefulWidget {
  static var tag = "/ShowInitiatives";

  @override
  ShowInitiativesState createState() => ShowInitiativesState();
}

class ShowInitiativesState extends State<ShowInitiatives> {
  int selectedPos = 1;
  List<ListModel> mListings_new;
  List<ListModel> mListings_trend;
  List<ListModel> mListings_current;

  @override
  void initState() {
    super.initState();
    selectedPos = 1;
    mListings_new = List.filled(
        5,
        ListModel(
            name: "Javier",
            description: "asdfafd",
            icon: "assets/initiatives/initiative_1.jpg",
            duration: "10",
            type: "new"));

    mListings_trend = List.filled(
        5,
        ListModel(
            name: "Quijano",
            description: "asdfafd",
            icon: "assets/initiatives/initiative_1.jpg",
            duration: "10",
            type: "trend"));

    mListings_current = mListings_new;
  }

  @override
  Widget build(BuildContext context) {
    //var width = MediaQuery.of(context).size.width;
    changeStatusColor(Globals.appStore.appBarColor);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            onTap: (value) {
              setState(() {
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
                  ListIniatives(mListings: mListings_new),
                  ListIniatives(mListings: mListings_trend),
                  ListIniatives(mListings: mListings_new),
                ]))),
      ),
    );
  }
}
