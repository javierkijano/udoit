import 'package:flutter/material.dart';
import 'package:udoit/models/AppGlobals.dart';
import 'package:udoit/models/initiative.dart';
import 'package:udoit/widgets/AppWidget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/utils/AppColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:udoit/utils/AppConstant.dart';
import 'package:udoit/description/description.dart';
//import 'package:udoit/showInitiatives/models/models.dart';

class IniativesListItem extends StatelessWidget {
  int index;
  /*String imageUrl;
  String title;
  String category;
  String date;
  String summary;
  */
  Initiative initiative;

  IniativesListItem(
      { //@required this.imageUrl,
      //@required this.title,
      //@required this.category,
      //@required this.date,
      //@required this.summary,
      @required this.initiative,
      this.index = 0});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.5,
            child: CachedNetworkImage(
              imageUrl: this.initiative.imagesUrls[0],
              fit: BoxFit.cover,
            ).cornerRadiusWithClipRRect(10).paddingTop(16),
          ),
          Container(
            height: 90,
            width: MediaQuery.of(context).size.width * 0.5,
            color: blackColor.withOpacity(0.7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                text(
                  this.initiative.title,
                  textColor: whiteColor,
                  fontSize: textSizeNormal,
                  fontFamily: fontBold,
                ),
                text(this.initiative.summary,
                        textColor: whiteColor,
                        fontSize: textSizeMedium,
                        fontFamily: fontRegular)
                    .paddingTop(4),
              ],
            ).paddingAll(16),
          ).cornerRadiusWithClipRRect(10)
        ],
      ).paddingAll(10),
      onTap: () {
        Navigator.pushNamed(context, Description.tag,
            arguments: this.initiative);
      },
    );
  }
}
