import 'package:flutter/material.dart';
//import 'package:udoit/screens/splashscreen/AppSplashScreen.dart';

//import 'package:udoit/screens/splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:udoit/main/utils/flix_app_localizations.dart';
//import 'package:udoit/store/Globals.appStore.dart';
import 'package:udoit/routes.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:udoit/main/utils/AppConstant.dart';
import 'package:udoit/main/utils/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool USE_FIRESTORE_EMULATOR = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.settings = Settings(
        host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
  }
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

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
        localeResolutionCallback: (locale, supportedLocales) =>
            Locale(Globals.appStore.selectedLanguage),
        locale: Locale(Globals.appStore.selectedLanguage),
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
