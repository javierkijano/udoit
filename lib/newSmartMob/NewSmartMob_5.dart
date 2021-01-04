import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/widgets/Button1.dart';

import 'package:flutter/foundation.dart';
import 'package:udoit/utils/youtube/Youtube.dart';
import 'package:udoit/utils/gallery_image_picker/generic_gallery_image_picker.dart';

class NewSmartMob5 extends StatefulWidget {
  static String tag = '/NewSmartMob5';
  final String title = 'Add a new iniative';

  const NewSmartMob5({Key key}) : super(key: key);

  @override
  NewSmartMob5State createState() => new NewSmartMob5State();
}

class NewSmartMob5State extends State<NewSmartMob5>
    with AutomaticKeepAliveClientMixin<NewSmartMob5> {
  String videoUrl;
  List<Uint8image> uint8images = [];
  bool showVideo = false;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  //creating Key for container
  //GlobalKey _keyContainer = GlobalKey();

  Image currentImage =
      Image.asset('assets/newSmartMob/uploadImageIcon.png', height: 100);

  void _onPressedUploadImage() async {
    Uint8image _uint8image;

    _uint8image = await generic_gallery_image_picker();

    setState(() {
      currentImage =
          Image.memory(_uint8image.data, semanticLabel: _uint8image.name);
    });
    uint8images.add(_uint8image);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: false,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            //height: MediaQuery.of(context).size.height,
            //child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Añade una foto o un vídeo',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Las peticiones con foto o vídeo consiguen hasta 6 veces más firmas que peticiones que no tienen. Incluye una foto o un vídeo que capture la emoción de tu historia.',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 20),
                // create the illusion of a beautifully scrolling text box
                Container(
                  //key: _keyContainer,
                  decoration: BoxDecoration(border: Border.all(width: 1)), // ,
                  //color: Colors.gray,
                  padding: new EdgeInsets.all(20.0),

                  child: new Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Row(children: <Widget>[]),
                      ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 100),
                          child: currentImage),
                      SizedBox(height: 20),
                      Button1(
                        textContent: "Subir",
                        onPressed: _onPressedUploadImage,
                        isStroked: true,
                      ),
                      SizedBox(height: 40),
                      Builder(builder: (context) {
                        if (!showVideo)
                          return Image.asset(
                              'assets/newSmartMob/uploadVideoIcon.png',
                              height: 100);
                        else {
                          return YoutubeApp(videoUrl);
                        }
                      }),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: new InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'http://',
                          labelText: 'dirección web del video',
                        ),
                        onChanged: (text) {
                          videoUrl = text;
                        },
                      ),
                      SizedBox(height: 20),
                      Button1(
                          textContent: "Subir",
                          onPressed: () {
                            setState(() {
                              showVideo = true;
                            });
                          },
                          isStroked: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
