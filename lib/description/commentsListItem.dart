import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/utils/AppColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:udoit/showInitiatives/models/models.dart';

class CommentsListItem extends StatelessWidget {
  String profilePhotoUrl;
  String name;
  String text;
  DateTime dateTime;
  int likes;
  int index;

  CommentsListItem(
      {@required this.profilePhotoUrl,
      @required this.name,
      @required this.text,
      @required this.dateTime,
      @required this.likes,
      this.index = 0});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        Divider(thickness: 0.5, color: Colors.grey),
        Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          /*decoration: BoxDecoration(
              color: scaffoldBackground,
              borderRadius: BorderRadius.circular(5),
              boxShadow: defaultBoxShadow()),*/
          child: Row(
            children: <Widget>[
              CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(profilePhotoUrl),
                  radius: 30),
              SizedBox(width: 16),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(name),
                          SizedBox(width: 30),
                          Text(dateTime.toString()),
                        ],
                      ),
                      Text(text,
                          overflow: TextOverflow.ellipsis,
                          style: primaryTextStyle(size: 14),
                          maxLines: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.favorite_border_outlined),
                          SizedBox(width: 30),
                          Text(likes.toString()),
                          SizedBox(width: 30),
                          Text('Denunciar'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
