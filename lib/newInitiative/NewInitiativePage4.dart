import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
//import 'package:udoit/widgets/htmlEditor.dart';
//import 'dart:html' as html;
//import 'dart:convert';
//import 'package:http/http.dart' as http;
//import 'package:html/parser.dart' as html_parser;
import 'package:udoit/widgets/htmlVisualizer.dart';

class NewSmartMob4 extends StatefulWidget {
  static String tag = '/NewSmartMob4';
  final String title = 'Add a new iniative';

  const NewSmartMob4({Key key}) : super(key: key);

  @override
  NewSmartMob4State createState() => new NewSmartMob4State();
}

class NewSmartMob4State extends State<NewSmartMob4>
    with AutomaticKeepAliveClientMixin<NewSmartMob4> {
  String summary;
  String request;
  bool isRequestHtml = false;

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

            /*ListView(
            padding: const EdgeInsets.all(12),
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),*/
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 2,
                        maxLines: 1000000, //grow automatically
                        maxLength: 100,
                        maxLengthEnforced: true,
                        //focusNode: mrFocus,
                        //controller: _textController,
                        //onSubmitted: currentIsComposing ? _handleSubmitted : null,
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          hintText:
                              'Describe brevemente el objetivo de tu petición',
                          labelText: 'Resumen petición (max. 1000 caracteres)',
                        ),
                        onChanged: (text) async {
                          summary = text;
                        }),
                    SizedBox(height: 20),
                    /*
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: 400,
                    maxWidth: MediaQuery.of(context).size.width),
                child: HtmlEditor(
                  title: 'holahola',
                ),
              ),
              */

                    TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 10,
                        maxLines: 1000000,
                        maxLength: 10000,
                        maxLengthEnforced: true,
                        //focusNode: mrFocus,
                        //controller: _textController,
                        //onSubmitted: currentIsComposing ? _handleSubmitted : null,
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          hintText:
                              'Describe brevemente el objetivo de tu petición. Si quieres resumir la propuesta utilizando html, no olvides empezar con <!DOCTYPE html>',
                          labelText:
                              'Resumen petición (max. 100000 caracteres)',
                        ),
                        onChanged: (text) {
                          setState(() {
                            request = text;
                            if (text.startsWith('<!DOCTYPE html>'))
                              isRequestHtml = true;
                            else
                              isRequestHtml = false;
                          });
                        }),
                    isRequestHtml
                        ? HtmlVisualizer(request)
                        : SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
