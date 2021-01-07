import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/widgets/Button1.dart';

import 'package:flutter/foundation.dart';
import 'package:udoit/utils/youtube/Youtube.dart';
import 'package:udoit/utils/gallery_image_picker/generic_gallery_image_picker.dart';
import 'package:udoit/widgets/ListScreen.dart';

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
  List<dynamic> pickedImages = [];
  bool showVideo = false;
  GlobalKey<ListScreenState> _keyListScreenState;
  Widget _listScreen;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _keyListScreenState = GlobalKey();
    _listScreen =
        ListScreen(key: _keyListScreenState, scrollDirection: Axis.horizontal);
    int a = 0;
  }

  //creating Key for container
  //GlobalKey _keyContainer = GlobalKey();

  Image defaultImage =
      Image.asset('assets/newSmartMob/uploadImageIcon.png', height: 100);

  void _onPressedUploadImage() async {
    dynamic _pickedImage = await generic_gallery_image_picker();

    /*setState(() {
      currentImage =
          Image.memory(_pickedImage.data, semanticLabel: _pickedImage['name']);
    });
    */
    pickedImages.add(_pickedImage);
    _keyListScreenState.currentState.add(List.filled(
        1,
        Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Image.memory(_pickedImage['data'],
                semanticLabel: _pickedImage['name'], fit: BoxFit.fitHeight))));
    setState(() {});
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
                      if (pickedImages.length == 0) defaultImage,
                      Container(
                          height: pickedImages.length == 0 ? 0 : 100,
                          child: _listScreen),
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
