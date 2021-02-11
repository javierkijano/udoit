import 'package:flutter/material.dart';
import 'package:udoit/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

class SearchBar extends StatefulWidget {
  Function(String) onTextInputCallback;
  String initialText;
  bool autofocus;

  SearchBar(
      {Key key,
      this.initialText,
      this.autofocus = false,
      this.onTextInputCallback})
      : super(key: key) {}

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = new TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 30,
      child: TextField(
          autofocus: widget.autofocus,
          controller: _textController,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: appWhite,
            hintText: "Busca una iniciativa",
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search, size: 30, color: appColorPrimary)
                .paddingAll(5),
            contentPadding:
                EdgeInsets.only(left: 16.0, bottom: 4.0, top: 4.0, right: 16.0),
          ),
          onChanged: (text) {
            if (widget.onTextInputCallback != null)
              widget.onTextInputCallback(text);
          }).cornerRadiusWithClipRRect(20),
      alignment: Alignment.center,
    ).cornerRadiusWithClipRRect(10).paddingAll(10);
  }
}
