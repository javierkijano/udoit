//https://medium.com/@shakleenishfar/leaf-flutter-social-media-app-part-8-post-page-and-comments-78eefb8ff447

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/models/AppGlobals.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:udoit/models/fireManager.dart';
import 'package:udoit/models/initiative.dart';
import 'package:udoit/widgets/ListScreen.dart';
import 'package:udoit/description/commentsListItem.dart';
import 'dart:math';
import 'package:udoit/utils/AppColors.dart';
import 'package:flutter/services.dart';
import 'package:udoit/models/comment.dart';

class PageComments extends StatefulWidget {
  static String tag = '/PageComments';
  final String title = 'Comments';
  Initiative initiative;

  PageComments({Key key, this.initiative}) : super(key: key);

  @override
  PageCommentsState createState() => new PageCommentsState();
}

class PageCommentsState extends State<PageComments>
    with AutomaticKeepAliveClientMixin<PageComments> {
  Random rand = Random();
  int _randomSeedCommentsQuery;
  int numDocs = 10;
  String currentText;

  Future<List<CommentsListItem>> commentsListItemFetcher(
      int start, int end) async {
    List<CommentsListItem> list = <CommentsListItem>[];
    int numDocs = end - start + 1;

    (await Globals.fireManager.downloadInitiativeComments(
            widget.initiative.id, numDocs, _randomSeedCommentsQuery))
        .forEach((element) {
      //user = await Globals.fireManager.downloadUser(userID);

      String profilePhotoUrl = Globals.appUser.profilePhotoUrl;
      String name = Globals.appUser.name;
      list.add(CommentsListItem(
          profilePhotoUrl: profilePhotoUrl, //user.profilePhotoUrl;
          name: name, //user.name;
          text: element.text,
          dateTime: element.dateTime,
          likes: element.likes));
    });
    return list;
  }

  @override
  void initState() {
    super.initState();
    _randomSeedCommentsQuery = rand.nextInt(1000000);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            CircleAvatar(
                backgroundImage: Globals.appUser.profilePhotoImageProvider,
                radius: 30),
            SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Añade un comentario público ...',
                  //labelText: 'Título de la petición (max. 100 caracteres )',
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(100),
                ],
                onChanged: (text) {
                  currentText = text;
                },
                onSaved: (text) async {
                  print('upload comment to firestore');
                  Globals.fireManager.uploadCommentToFirestore(
                      widget.initiative.id,
                      Comment(
                          userId: Globals.appUser.id,
                          dateTime: DateTime.now(),
                          text: text,
                          likes: 0));
                },
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              child: Icon(
                Icons.add_circle_outline_sharp,
                size: 40.0,
                color: Colors.blue,
                semanticLabel: 'Send comment',
              ),
              onTap: () {
                print('upload comment to firestore');
                Globals.fireManager.uploadCommentToFirestore(
                    widget.initiative.id,
                    Comment(
                        userId: Globals.appUser.uid,
                        dateTime: DateTime.now(),
                        text: currentText,
                        likes: 0));
              },
            )
          ],
        ),
        Expanded(child: ListScreen(itemFetcher: commentsListItemFetcher)),
      ],
    );
  }
}
