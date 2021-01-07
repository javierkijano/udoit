import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class NewSmartMob3 extends StatefulWidget {
  static String tag = '/NewSmartMob3';
  final String title = 'Add a new iniative';

  const NewSmartMob3({Key key}) : super(key: key);

  @override
  NewSmartMob3State createState() => new NewSmartMob3State();
}

class NewSmartMob3State extends State<NewSmartMob3>
    with AutomaticKeepAliveClientMixin<NewSmartMob3> {
  String destinatary = '';

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
        padding: const EdgeInsets.all(20.0),
        height: MediaQuery.of(context).size.height,
        //child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '¡Genial! ¿Quién puede solucionar el problema que planteas en tu petición?',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Elige el destinatario o destinatarios a los que dirigir tu petición. Pueden ser personas, empresas o administraciones públicas con el poder para solucionar el problema que explicas en tu petición.',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: const Icon(Icons.person),
                hintText: 'Alcalde de Barcelona',
                labelText: 'Destinatario de la petición',
              ),
              onChanged: (text) {
                destinatary = text;
              },
            ),
          ],
        ),
      ),
    );
  }
}
