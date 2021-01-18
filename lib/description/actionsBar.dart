import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class IniativeActionBar extends StatefulWidget {
  double iconSize;
  double iconTextSize;

  IniativeActionBar({Key key, this.iconSize = 30.0, this.iconTextSize = 15.0})
      : super(key: key);

  @override
  IniativeActionBarState createState() => new IniativeActionBarState();
}

class IniativeActionBarState extends State<IniativeActionBar> {
  int upVotes = 203;
  int downVotes = 2;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            children: [
              Icon(
                Icons.thumb_up_outlined,
                //color: Colors.white,
                size: widget.iconSize,
                semanticLabel: 'voting up',
              ),
              Text(
                upVotes.toString(),
                style: TextStyle(
                  fontSize: widget.iconTextSize,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.thumb_down_outlined,
                //color: Colors.white,
                size: widget.iconSize,
                semanticLabel: 'voting down',
              ),
              Text(
                downVotes.toString(),
                style: TextStyle(
                  fontSize: widget.iconTextSize,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.share_outlined,
                //color: Colors.white,
                size: widget.iconSize,
                semanticLabel: 'share it with your friends',
              ),
              Text(
                'Compartir',
                style: TextStyle(
                  fontSize: widget.iconTextSize,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.add_box_outlined,
                //color: Colors.white,
                size: widget.iconSize,
                semanticLabel: 'add the iniative to your favorites',
              ),
              Text(
                'Favoritos',
                style: TextStyle(
                  fontSize: widget.iconTextSize,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.comment_outlined,
                //color: Colors.white,
                size: widget.iconSize,
                semanticLabel: 'Añadae un comentario',
              ),
              Text(
                'Comentar',
                style: TextStyle(
                  fontSize: widget.iconTextSize,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.add_alert_outlined,
                //color: Colors.white,
                size: widget.iconSize,
                semanticLabel: 'set up an alert for breaking udpates',
              ),
              Text(
                'Alert',
                style: TextStyle(
                  fontSize: widget.iconTextSize,
                ),
              ),
            ],
          ),
        ]));
  }
}
