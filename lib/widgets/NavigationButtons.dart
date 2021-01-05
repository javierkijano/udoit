import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/widgets/Button1.dart';

import 'package:flutter/foundation.dart';
import 'package:udoit/utils/dots_indicator/dots_indicator.dart';
import 'package:udoit/utils/AppColors.dart';

class NavigationButtons extends StatefulWidget {
  static String tag = '/NavigationButtons';
  int numPages;
  String afterCancelRouteName;
  String afterFinishRouteName;
  String prevButtonText;
  String cancelButtonText;
  String nextButtonText;
  String finishButtonText;

  dynamic Function(int) onNavigateCallback;
  dynamic Function() onCancelCallback;
  dynamic Function() onFinishCallback;

  Observable<int> externalPage;

  int initialPageIndex;

  NavigationButtons(
      {@required this.numPages,
      this.afterCancelRouteName,
      this.afterFinishRouteName,
      this.prevButtonText = 'Prev',
      this.cancelButtonText = 'Cancel',
      this.nextButtonText = 'Next',
      this.finishButtonText = 'Finish',
      this.onNavigateCallback,
      this.onCancelCallback,
      this.onFinishCallback,
      this.initialPageIndex = 0,
      Key key})
      : super(key: key);

  @override
  NavigationButtonsState createState() => new NavigationButtonsState();

  //return context.findAncestorStateOfType<NavigationButtonsState>();

}

class NavigationButtonsState extends State<NavigationButtons> {
  GlobalKey<Button1State> button1prev_key = GlobalKey();
  GlobalKey<Button1State> button1cancel_key = GlobalKey();
  GlobalKey<Button1State> button1next_key = GlobalKey();
  GlobalKey<Button1State> button1finish_key = GlobalKey();

  int currentPageIndex;
  //bool finishButtonEnabled = false;
  bool isPrevButtonStroked = false;

  Future<bool> setPageIndex(int pageIndex) async {
    assert(pageIndex >= 0 && (pageIndex < widget.numPages));
    if (pageIndex != currentPageIndex) {
      setState(() {
        if (currentPageIndex == 0) isPrevButtonStroked = true;
        if (pageIndex == 0) isPrevButtonStroked = false;
        currentPageIndex = pageIndex;
      });
      if (widget.onNavigateCallback != null)
        await widget.onNavigateCallback(currentPageIndex);
      return true;
    } else
      return false;
  }

  void onPrev() {
    setPageIndex(currentPageIndex - 1);
  }

  void onNext() {
    setPageIndex(currentPageIndex + 1);
  }

  void onCancel() async {
    if (widget.onCancelCallback != null) await widget.onCancelCallback();
    /*
    if (widget.afterCancelRouteName != null)
      Navigator.pushNamed(context, widget.afterCancelRouteName);
    else
      Navigator.pop(context);
    */
  }

  void onFinish() async {
    if (widget.onFinishCallback != null) await widget.onFinishCallback();
    /*
    if (widget.afterFinishRouteName != null)
      await Navigator.pushNamed(context, widget.afterFinishRouteName);
    else
      Navigator.pop(context);
    */
  }

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.initialPageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
              child: Button1(
                  textContent: widget.prevButtonText,
                  onPressed: onPrev,
                  isStroked: isPrevButtonStroked,
                  key: button1prev_key)),
          DotsIndicator(
              dotsCount: this.widget.numPages,
              position: currentPageIndex,
              decorator: DotsDecorator(
                size: const Size.fromRadius(5.0),
                activeSize: const Size.fromRadius(10.0),
                color: t4_view_color,
                activeColor: t4_colorPrimary,
                spacing: const EdgeInsets.all(5.0),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Button1(
                textContent: widget.cancelButtonText,
                onPressed: onCancel,
                isStroked: true,
                key: button1cancel_key,
              ),
              if (currentPageIndex < widget.numPages - 1)
                Button1(
                  textContent: widget.nextButtonText,
                  onPressed: onNext,
                  isStroked: true,
                  key: button1next_key,
                )
              else
                Button1(
                  textContent: widget.finishButtonText,
                  onPressed: onFinish,
                  isStroked: true,
                  key: button1finish_key,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
