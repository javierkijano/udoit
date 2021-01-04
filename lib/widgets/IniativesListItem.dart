import 'package:flutter/material.dart';
import 'package:udoit/utils/AppGlobals.dart';
import 'package:udoit/widgets/AppWidget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/utils/AppColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:udoit/showInitiatives/models/models.dart';

class IniativesListItem extends StatelessWidget {
  IniativesListItem(this.initiativeData, {this.index = 0});
  //final Widget child;
  final ListModel initiativeData;
  final int index;

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
                    imageUrl: initiativeData.icon,
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
                            child: Text(index % 2 == 0 ? "New" : "Popular",
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
                            Text(initiativeData.name,
                                style: primaryTextStyle(
                                    color: textPrimaryColor, size: 18)),
                            SizedBox(height: 4),
                            Text(initiativeData.duration,
                                style: primaryTextStyle(size: 14)),
                            SizedBox(height: 4),
                            Text(initiativeData.description,
                                style: primaryTextStyle(size: 14), maxLines: 1),
                            SizedBox(height: 4),
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
