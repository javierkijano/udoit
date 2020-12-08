import 'package:flutter/material.dart';
import 'package:udoit/main/utils/globals.dart';
import 'package:udoit/main/widgets/AppWidget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/main/utils/AppColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:udoit/main/showInitiatives/models/models.dart';

class ListIniatives extends StatelessWidget {
  const ListIniatives({Key key, this.mListings, this.child}) : super(key: key);
  final Widget child;
  final List<ListModel> mListings;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: mListings.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              decoration: BoxDecoration(
                  color: Globals.appStore.scaffoldBackground,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: defaultBoxShadow()),
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Globals.appStore.scaffoldBackground,
                child: Row(
                  children: <Widget>[
                    CachedNetworkImage(
                        placeholder: placeholderWidgetFn(),
                        imageUrl: mListings[index].icon,
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
                                  color: index % 2 == 0
                                      ? t2_red
                                      : app_primaryColor,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(16.0),
                                      topRight: Radius.circular(16.0)),
                                ),
                                padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                child: Text(index % 2 == 0 ? "New" : "Popular",
                                    style: primaryTextStyle(
                                        color: white, size: 12)),
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
                                Text(mListings[index].name,
                                    style: primaryTextStyle(
                                        color:
                                            Globals.appStore.textPrimaryColor,
                                        size: 18)),
                                SizedBox(height: 4),
                                Text(mListings[index].duration,
                                    style: primaryTextStyle(size: 14)),
                                SizedBox(height: 4),
                                Text(mListings[index].description,
                                    style: primaryTextStyle(size: 14),
                                    maxLines: 1),
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
          );
        },
      ),
    );
  }
}
