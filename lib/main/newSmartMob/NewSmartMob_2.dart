import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:udoit/main/newSmartMob/NewSmartMob_5.dart';
//import 'package:udoit/main/newSmartMob/NewSmartMob.dart';
import 'package:udoit/main/newSmartMob/models/NewSmartMobModel.dart';

class NewSmartMob2 extends StatefulWidget {
  static String tag = '/NewSmartMob2';
  final String title = 'Add a new iniative';

  const NewSmartMob2({Key key}) : super(key: key);

  @override
  NewSmartMob2State createState() => new NewSmartMob2State();
}

class NewSmartMob2State extends State<NewSmartMob2>
    with AutomaticKeepAliveClientMixin<NewSmartMob2> {
  String title;

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
              'Escribe el título de tu petición',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Es lo primero que la gente verá de tu petición. Consigue su atención con un titular corto que se centre en el cambio que quieres que apoyen.',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: const Icon(Icons.person),
                hintText: '¿Qué quieres conseguir?',
                labelText: 'Título de la petición',
              ),
              onChanged: (text) {
                title = text;
              },
            ),
          ],
        ),
      ),
    );
  }
}
