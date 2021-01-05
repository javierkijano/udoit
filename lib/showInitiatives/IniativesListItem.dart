import 'package:flutter/material.dart';
import 'package:udoit/models/AppGlobals.dart';
import 'package:udoit/widgets/AppWidget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/utils/AppColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:udoit/showInitiatives/models/models.dart';

class IniativesListItem extends StatelessWidget {
  int index;
  String imageUrl;
  String title;
  String category;
  String date;
  String summary;

  IniativesListItem(
      {@required this.imageUrl,
      @required this.title,
      @required this.category,
      @required this.date,
      @required this.summary,
      this.index = 0});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          decoration: BoxDecoration(
              color: scaffoldBackground,
              borderRadius: BorderRadius.circular(10),
              boxShadow: defaultBoxShadow()),
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: scaffoldBackground,
            child: Row(
              children: <Widget>[
                CachedNetworkImage(
                    placeholder: placeholderWidgetFn(),
                    imageUrl: imageUrl,
                    width: width / 3,
                    height: width / 2.8,
                    fit: BoxFit.fill),
                Container(
                  width: width - (width / 3) - 35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: index % 2 == 0 ? t2_red : app_primaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(16.0),
                                  topRight: Radius.circular(16.0)),
                            ),
                            padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                            child: Text(index % 2 == 0 ? "Par" : "Impar",
                                style:
                                    primaryTextStyle(color: white, size: 12)),
                          ),
                          GestureDetector(
                              onTap: () {}, child: Icon(Icons.more_vert))
                        ],
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              style: primaryTextStyle(
                                  color: textPrimaryColor, size: 18),
                              maxLines: 2,
                            ),
                            SizedBox(height: 4),
                            Text(category,
                                overflow: TextOverflow.ellipsis,
                                style: primaryTextStyle(size: 10),
                                maxLines: 1),
                            SizedBox(height: 4),
                            Text(date,
                                overflow: TextOverflow.ellipsis,
                                style: primaryTextStyle(size: 10),
                                maxLines: 1),
                            SizedBox(height: 4),
                            Text(summary,
                                overflow: TextOverflow.ellipsis,
                                style: primaryTextStyle(size: 14),
                                maxLines: 3),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.all(0),
          ),
        ),
      ),
    );
  }
}
