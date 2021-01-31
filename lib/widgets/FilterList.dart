import 'package:flutter/cupertino.dart';
import 'package:udoit/utils/AppConstant.dart';
import 'package:udoit/utils/AppColors.dart';
import 'package:flutter/material.dart';

class FilterList extends StatefulWidget {
  List<String> _filtersNamesList = [];
  void Function(List<int>) onFiltersChanged;

  FilterList(
      {Key key, @required List<String> filtersNamesList, this.onFiltersChanged})
      : super(key: key) {
    filtersNamesList.forEach((element) {
      _filtersNamesList.add('#' + element);
    });
  }

  @override
  FilterListState createState() => FilterListState();
}

class FilterListState extends State<FilterList> {
  List<bool> filtersActivatedList;

  @override
  void initState() {
    super.initState();
    filtersActivatedList =
        List<bool>.filled(widget._filtersNamesList.length, false);
  }

  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget._filtersNamesList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            color: Colors.transparent,
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: new BoxDecoration(
                    color: filtersActivatedList[index]
                        ? appColorPrimary
                        : appWhite,
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(40.0))),
                alignment: Alignment.center,
                child: Text(
                  widget._filtersNamesList[index],
                  style: TextStyle(
                    color: filtersActivatedList[index]
                        ? appWhite
                        : appColorPrimary,
                    fontSize: textSizeLargeMedium,
                    fontFamily: fontRegular,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {
                setState(() {
                  filtersActivatedList[index] = !filtersActivatedList[index];
                });
                if (widget.onFiltersChanged != null) {
                  List<int> activatedFiltersIndices = [];
                  for (int i = 0; i < filtersActivatedList.length; i++)
                    if (filtersActivatedList[i] == true)
                      activatedFiltersIndices.add(i);
                  widget.onFiltersChanged(activatedFiltersIndices);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
