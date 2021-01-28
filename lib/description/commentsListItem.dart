import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/utils/AppColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:udoit/showInitiatives/models/models.dart';

class CommentsListItem extends StatefulWidget {
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
  CommentsListItemState createState() => new CommentsListItemState();
}

class CommentsListItemState extends State<CommentsListItem> {
  bool likeActive;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    likeActive = false;
  }

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
                  backgroundImage:
                      CachedNetworkImageProvider(widget.profilePhotoUrl),
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
                          Text(widget.name),
                          SizedBox(width: 30),
                          Text(widget.dateTime.toString()),
                        ],
                      ),
                      Text(widget.text,
                          overflow: TextOverflow.ellipsis,
                          style: primaryTextStyle(size: 14),
                          maxLines: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            child: likeActive
                                ? Icon(Icons.favorite_rounded,
                                    color: Colors.red)
                                : Icon(Icons.favorite_border,
                                    color: Colors.red),
                            onTap: () {
                              setState(() {
                                this.likeActive = !this.likeActive;
                              });
                            },
                          ),
                          SizedBox(width: 30),
                          Text(widget.likes.toString()),
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
