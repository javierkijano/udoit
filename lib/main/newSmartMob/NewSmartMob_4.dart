import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

class NewSmartMob4 extends StatefulWidget {
  static String tag = '/NewSmartMob4';
  final String title = 'Add a new iniative';

  const NewSmartMob4({Key key}) : super(key: key);

  @override
  NewSmartMob4State createState() => new NewSmartMob4State();
}

class NewSmartMob4State extends State<NewSmartMob4>
    with AutomaticKeepAliveClientMixin<NewSmartMob4> {
  String request;

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
              'Explica el problema que quieres resolver',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Es más probable que la gente apoye tu petición si explicas por qué te importa. Explica cómo este cambio te afectaría a ti, tu familia o tu comunidad.',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 20),
            // create the illusion of a beautifully scrolling text box
            Container(
              //color: Colors.gray,
              padding: new EdgeInsets.all(7.0),

              child: new ConstrainedBox(
                constraints: new BoxConstraints(
                  //minWidth: _getContainerWidth(),
                  //maxWidth: _getContainerWidth(),
                  minHeight: MediaQuery.of(context).size.height * 0.5,
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                  //minHeight: AppMeasurements.isLandscapePhone(context) ? 25.0 : 25.0,
                ),
                child: new SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  reverse: false,

                  // here's the actual text box
                  child: new TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null, //grow automatically
                      //focusNode: mrFocus,
                      //controller: _textController,
                      //onSubmitted: currentIsComposing ? _handleSubmitted : null,
                      decoration: new InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Please enter a lot of text',
                      ),
                      onChanged: (text) {
                        request = text;
                      }),
                  // ends the actual text box
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
