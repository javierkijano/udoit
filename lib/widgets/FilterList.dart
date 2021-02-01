import 'package:flutter/cupertino.dart';
import 'package:udoit/utils/AppConstant.dart';
import 'package:udoit/utils/AppColors.dart';
import 'package:flutter/material.dart';

class FilterList extends StatefulWidget {
  List<String> _filtersNamesList = [];
  List<String> _filtersList = [];

  void Function(List<String>) onFiltersChanged;

  FilterList(
      {Key key, @required List<String> filtersList, this.onFiltersChanged})
      : super(key: key) {
    _filtersList = filtersList;
    filtersList.forEach((element) {
      _filtersNamesList.add('#' + element);
    });
  }

  @override
  FilterListState createState() => FilterListState();
}

class FilterListState extends State<FilterList> {
  List<bool> filtersActivatedList;
  bool filterAllActivated;

  @override
  void initState() {
    super.initState();
    filtersActivatedList =
        List<bool>.filled(widget._filtersNamesList.length, true);
    filterAllActivated = true;
  }

  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        children: [
          VerticalDivider(
            width: 15,
            thickness: 0.5,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            color: Colors.transparent,
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: new BoxDecoration(
                    color: filterAllActivated ? appColorPrimary : appWhite,
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(40.0))),
                alignment: Alignment.center,
                child: Text(
                  '#all',
                  style: TextStyle(
                    color: filterAllActivated ? appWhite : appColorPrimary,
                    fontSize: textSizeLargeMedium,
                    fontFamily: fontRegular,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {
                setState(() {
                  filterAllActivated = !filterAllActivated;
                  filtersActivatedList = List<bool>.filled(
                      widget._filtersNamesList.length, filterAllActivated);
                });
                if (filterAllActivated)
                  widget.onFiltersChanged(widget._filtersList);
                else
                  widget.onFiltersChanged(List<String>());
              },
            ),
          ),
          VerticalDivider(
            width: 15,
            thickness: 0.5,
          ),
          Expanded(
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
                          borderRadius: new BorderRadius.all(
                              const Radius.circular(40.0))),
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
                        filtersActivatedList[index] =
                            !filtersActivatedList[index];
                      });
                      if (widget.onFiltersChanged != null) {
                        List<String> activatedFilters = [];
                        for (int i = 0; i < filtersActivatedList.length; i++)
                          if (filtersActivatedList[i] == true)
                            activatedFilters.add(widget._filtersList[i]);
                        widget.onFiltersChanged(activatedFilters);
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
