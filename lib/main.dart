import 'package:flutter/material.dart';
//import 'package:udoit/screens/splashscreen/AppSplashScreen.dart';

//import 'package:udoit/screens/splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:udoit/models/initiatives.dart';
import 'package:udoit/utils/flix_app_localizations.dart';
//import 'package:udoit/store/Globals.appStore.dart';
import 'package:udoit/routes.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/utils/AppConstant.dart';
import 'package:udoit/utils/AppGlobals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:udoit/models/configuration.dart';

import 'package:firebase_image/firebase_image.dart';

bool USE_FIRESTORE_EMULATOR = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.settings = Settings(
        host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
  }
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  print(await Globals.appConf.categories);

  // Create a reference with an initial file path and name
  /*var imageUrl = await FirebaseStorage.instance
      .refFromURL(
          'gs://smartmobs-8bebb.appspot.com/configuration/categories/animales.png')
      .getDownloadURL();
      */

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          MuviAppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        localeResolutionCallback: (locale, supportedLocales) => Locale('es'),
        locale: Locale('es'),
        supportedLocales: [Locale('en', '')],
        initialRoute: '/ProkitSplashScreen',
        routes: routes(),
        title: '$mainAppName${!isMobile ? ' ${platformName()}' : ''}',

        //home: AppSplashScreen(),

        /*
        theme: !Globals.appStore.isDarkModeOn
            ? AppThemeData.lightTheme
            : AppThemeData.darkTheme,
        */
        builder: scrollBehaviour(),
      ),
    );
  }
}
