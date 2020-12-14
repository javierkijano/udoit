import 'package:udoit/main/store/AppStore.dart';
import 'package:udoit/main/models/configuration.dart';

class Globals {
  static var appStore = AppStore();
  static bool loggedIn = false;
  static String userName = 'Javier G.';
  static String userEmail = 'javierkijano@gmail.com';
  static String userPhoneNumber = 'javierkijano@gmail.com';
  static var fbApp;
  static Configuration appConf = Configuration(version: 'v0.1');
}
