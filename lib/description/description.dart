import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udoit/dashboard/Dashboard.dart';
import 'package:udoit/models/AppGlobals.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/description/pageDetails.dart';
import 'package:udoit/description/pageUpdates.dart';
import 'package:udoit/description/pageComments.dart';

import 'package:udoit/login/Login.dart';
import 'package:udoit/models/initiative.dart';
import 'package:udoit/models/fireManager.dart';
import 'package:udoit/utils/AppColors.dart';
import 'package:udoit/utils/AppConstant.dart';

import 'package:udoit/utils/AppImages.dart';
import 'package:udoit/widgets/NavigationButtons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:udoit/widgets/AppWidget.dart';
import 'package:udoit/widgets/progressIndicator.dart';

class Description extends StatefulWidget {
  static var tag = "/Initiative";
  String title = 'udoit.org';

  Description({Key key}) : super(key: key);
  @override
  DescriptionState createState() => DescriptionState();
}

class DescriptionState extends State<Description> {
  int currentIndexPage = 0;
  Initiative initiative;

  PageController _controller = new PageController();

  GlobalKey<PageDetailsState> _keyPageDetailsState = GlobalKey();
  GlobalKey<PageCommentsState> _keyPageCommentsState = GlobalKey();
  GlobalKey<PageUpdatesState> _keyPageUpdatesState = GlobalKey();

  @override
  void initState() {
    super.initState();
    currentIndexPage = 0;
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        initiative = ModalRoute.of(context).settings.arguments;
        int a = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //changeStatusColor(Colors.transparent);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                text("udoit.org",
                    textColor: appWhite,
                    fontFamily: fontBold,
                    fontSize: textSizeLargeMedium),
                Expanded(child: Container())
              ],
            ),
          ),
          bottom: TabBar(
            onTap: (value) {
              setState(() {});
            },
            tabs: [
              Tab(text: "Detalles"),
              Tab(text: "Novedades"),
              Tab(text: "Comentarios"),
            ],
          ),
        ),
        body: Observer(
          builder: (_) => Container(
            width: MediaQuery.of(context).size.width,
            child: TabBarView(
              children: <Widget>[
                if (initiative != null)
                  PageDetails(key: _keyPageDetailsState, initiative: initiative)
                else
                  UdoitProgressIndicator(widthFactor: 0.3),
                if (initiative != null)
                  PageUpdates(key: _keyPageUpdatesState)
                else
                  UdoitProgressIndicator(widthFactor: 0.3),
                if (initiative != null)
                  PageComments(key: _keyPageCommentsState)
                else
                  UdoitProgressIndicator(widthFactor: 0.3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
