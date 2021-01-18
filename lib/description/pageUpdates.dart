import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/models/AppGlobals.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PageUpdates extends StatefulWidget {
  static String tag = '/PageUpdates';
  final String title = 'Descripción';

  const PageUpdates({Key key}) : super(key: key);

  @override
  PageUpdatesState createState() => new PageUpdatesState();
}

class PageUpdatesState extends State<PageUpdates>
    with AutomaticKeepAliveClientMixin<PageUpdates> {
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
