import 'package:flutter/material.dart';
import 'package:udoit/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

class SearchBar extends StatefulWidget {
  Function(String) onTextInputCallback;

  SearchBar({Key key, this.onTextInputCallback}) : super(key: key) {}

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 30,
      child: TextField(
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: appWhite,
            hintText: "Busca una iniciativa",
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search, size: 30, color: appColorPrimary)
                .paddingAll(5),
            contentPadding:
                EdgeInsets.only(left: 16.0, bottom: 8.0, top: 8.0, right: 16.0),
          ),
          onChanged: (text) {
            if (widget.onTextInputCallback != null)
              widget.onTextInputCallback(text);
          }).cornerRadiusWithClipRRect(20),
      alignment: Alignment.center,
    ).cornerRadiusWithClipRRect(10).paddingAll(16);
  }
}
