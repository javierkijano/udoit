import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:udoit/dashboard/Dashboard.dart';
import 'package:udoit/widgets/AppWidget.dart';
import 'package:udoit/models/AppGlobals.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/newInitiative/NewInitiativePage1.dart';
import 'package:udoit/newInitiative/NewInitiativePage2.dart';
import 'package:udoit/newInitiative/NewInitiativePage3.dart';
import 'package:udoit/newInitiative/NewInitiativePage4.dart';
import 'package:udoit/newInitiative/NewInitiativePage5.dart';
//import 'package:udoit/newInitiative/NewInitiativePage6.dart';

import 'package:udoit/login/Login.dart';
import 'package:udoit/models/initiatives.dart';
import 'package:udoit/utils/AppColors.dart';
import 'package:udoit/utils/AppImages.dart';
import 'package:udoit/widgets/NavigationButtons.dart';

class NewInitiative extends StatefulWidget {
  static var tag = "/NewInitiative";

  @override
  NewInitiativeState createState() => NewInitiativeState();
}

class NewInitiativeState extends State<NewInitiative> {
  int currentIndexPage = 0;
  GlobalKey<NavigationButtonsState> _navigationButtonsStateKey;

  PageController _controller = new PageController();

  GlobalKey<NewSmartMob1State> _keyNewSmartMob1State = GlobalKey();
  GlobalKey<NewSmartMob2State> _keyNewSmartMob2State = GlobalKey();
  GlobalKey<NewSmartMob3State> _keyNewSmartMob3State = GlobalKey();
  GlobalKey<NewSmartMob4State> _keyNewSmartMob4State = GlobalKey();
  GlobalKey<NewSmartMob5State> _keyNewSmartMob5State = GlobalKey();

  Initiative initiative;

  DateTime _initiativeDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _navigationButtonsStateKey = GlobalKey();
    currentIndexPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.transparent);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(t4_walk_bg,
              width: width * 0.8, height: height * 0.5, fit: BoxFit.fill),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: PageView(
              controller: _controller,
              children: <Widget>[
                NewSmartMob1(key: _keyNewSmartMob1State),
                NewSmartMob2(key: _keyNewSmartMob2State),
                NewSmartMob3(key: _keyNewSmartMob3State),
                NewSmartMob4(key: _keyNewSmartMob4State),
                NewSmartMob5(key: _keyNewSmartMob5State),
                //NewSmartMob6(key: _keyNewSmartMob6State),
              ],
              onPageChanged: (value) async {
                if (await _navigationButtonsStateKey.currentState
                    .setPageIndex(value))
                  setState(() {
                    currentIndexPage = value;
                    print("..onPageChanged.index${value.toString()}");
                  });
              },
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: NavigationButtons(
                key: _navigationButtonsStateKey,
                numPages: 5,
                cancelButtonText: 'Cancel',
                finishButtonText: 'Save',
                onFinishCallback: () async {
                  if (!Globals.user.loggedIn) {
                    Globals.user.alreadyRequestedToLogIn = true;
                    await Navigator.pushNamed(context, Login.tag);
                    await Globals.appInitiatives.addToFirestore(Initiative(
                        publisherUserId: Globals.user.uid,
                        dateTime: _initiativeDateTime,
                        category: _keyNewSmartMob1State.currentState.category,
                        title: _keyNewSmartMob2State.currentState.title,
                        destinatary:
                            _keyNewSmartMob3State.currentState.destinatary,
                        summary: _keyNewSmartMob4State.currentState.summary,
                        request: _keyNewSmartMob4State.currentState.request,
                        uint8images:
                            _keyNewSmartMob5State.currentState.uint8images,
                        youtubeVideoUrl:
                            _keyNewSmartMob5State.currentState.videoUrl));
                    Navigator.popUntil(
                        context, ModalRoute.withName(Dashboard.tag));
                  }
                },
                onCancelCallback: () {
                  if (currentIndexPage > 0)
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) => AlertDialog(
                        title: Text('Alerta'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('¿Estás seguro que quieres cerrar?'),
                              Text(
                                  'Si cierras perderas los datos introducidos'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancelar'),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            child: Text('Aceptar'),
                            onPressed: () {
                              Navigator.popUntil(
                                  context, ModalRoute.withName(Dashboard.tag));
                            },
                          ),
                        ],
                      ),
                    );
                },
                onNavigateCallback: (pageIndex) async {
                  await _controller.animateToPage(pageIndex,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.linear);
                  setState(() {
                    currentIndexPage = pageIndex;
                    print("...onNavigateIndex${pageIndex.toString()}");
                  });
                },
              )),
        ],
      ),
    );
  }
}
