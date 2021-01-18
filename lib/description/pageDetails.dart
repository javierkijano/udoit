import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/models/AppGlobals.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:udoit/models/initiative.dart';
import 'package:udoit/widgets/AppWidget.dart';
import 'package:udoit/description/actionsBar.dart';

class PageDetails extends StatefulWidget {
  static String tag = '/PageDetails';
  Initiative initiative;

  PageDetails({Key key, this.initiative}) : super(key: key) {
    int a = 0;
  }

  @override
  PageDetailsState createState() => new PageDetailsState();
}

class PageDetailsState extends State<PageDetails>
    with AutomaticKeepAliveClientMixin<PageDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        //padding: const EdgeInsets.all(16),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            CachedNetworkImage(
                placeholder: placeholderWidgetFn(),
                imageUrl: widget.initiative.imagesUrls[0],
                fit: BoxFit.fill),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.initiative.title,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(thickness: 0.5, color: Colors.grey),
            IniativeActionBar(),
            Divider(thickness: 0.5, color: Colors.grey),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.initiative.summary,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              //color: const Color(0xffee0000), // Red
              //height: 1000.0,
              alignment: Alignment.center,
              child: Text(
                widget.initiative.request,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
