import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:udoit/main/newSmartMob/NewSmartMob_2.dart';
//import 'package:udoit/main/newSmartMob/NewSmartMob.dart';
import 'package:udoit/main/newSmartMob/models/NewSmartMobModel.dart';

class NewSmartMob1 extends StatefulWidget {
  static String tag = '/NewSmartMob1';
  final String title = 'Add a new iniative';

  const NewSmartMob1({Key key}) : super(key: key);

  @override
  NewSmartMob1State createState() => new NewSmartMob1State();
}

class NewSmartMob1State extends State<NewSmartMob1>
    with AutomaticKeepAliveClientMixin<NewSmartMob1> {
  String category;

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
        //child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '¿Sobre qué tema es la petición que estás a punto de iniciar?',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Si eliges un tema, permites que udoit.org recomiende tu petición a personas que podrían estar interesadas',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(categoriesNames.length, (index) {
                  return Column(children: <Widget>[
                    IconButton(
                      icon: Image.asset(categoriesImages[index]),
                      iconSize: 120,
                      tooltip:
                          'Escoge esta categoría para empezar a luchas por ${categoriesNames[index]}',
                      //style: Theme.of(context).textTheme.headline5,
                      onPressed: () {
                        setState(() {
                          category = categoriesNames[index];
                        });
                      },
                    ),
                    Text(categoriesNames[index]),
                  ]);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
