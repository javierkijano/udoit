import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

//import 'package:udoit/newSmartMob/NewSmartMob_2.dart';
//import 'package:udoit/newSmartMob/NewSmartMob.dart';
//import 'package:udoit/newSmartMob/models/NewSmartMobModel.dart';
import 'package:udoit/models/configuration.dart';
import 'package:udoit/models/AppGlobals.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:udoit/models/initiative.dart';

class NewSmartMob1 extends StatefulWidget {
  static String tag = '/NewSmartMob1';
  final String title = 'Add a new iniative';

  const NewSmartMob1({Key key}) : super(key: key);

  @override
  NewSmartMob1State createState() => new NewSmartMob1State();
}

class NewSmartMob1State extends State<NewSmartMob1>
    with AutomaticKeepAliveClientMixin<NewSmartMob1> {
  List<Category> categories;
  Category category;

  List<Category> loadCategories() {
    return Globals.appConf.categories;
  }

  @override
  void initState() {
    super.initState();
    categories = loadCategories();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    if (categories == null)
      return Container();
    else
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
                  children: List.generate(categories.length, (index) {
                    return Column(children: <Widget>[
                      IconButton(
                          icon: CachedNetworkImage(
                            imageUrl: categories[index].iconUrl,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          /*FirebaseImage(
                                'https://storage.googleapis.com/smartmobs-8bebb.appspot.com/configuration/categories/animales.png',
                                shouldCache:
                                    true, // The image should be cached (default: True)
                                maxSizeBytes: 3000 *
                                    1000, // 3MB max file size (default: 2.5MB)
                                cacheRefreshStrategy: CacheRefreshStrategy
                                    .NEVER // Switch off update checking
                                )
                                */

                          iconSize: 120,
                          tooltip:
                              'Escoge esta categoría para empezar a luchas por ${categories[index].name}',
                          //style: Theme.of(context).textTheme.headline5,
                          onPressed: () {
                            setState(() {
                              category = categories[index];
                            });
                          }),
                      Text(categories[index].name),
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
