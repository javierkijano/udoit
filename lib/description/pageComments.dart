import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/models/AppGlobals.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PageComments extends StatefulWidget {
  static String tag = '/PageComments';
  final String title = 'Descripción';

  const PageComments({Key key}) : super(key: key);

  @override
  PageCommentsState createState() => new PageCommentsState();
}

class PageCommentsState extends State<PageComments>
    with AutomaticKeepAliveClientMixin<PageComments> {
  @override
  void initState() {
    super.initState();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
