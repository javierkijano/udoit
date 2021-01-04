# udoit
flutter pub global activate webdev
flutter clean
flutter pub get
flutter packages pub global run webdev build
flutter packages pub global run webdev serve



#  webview_flutter: ^1.0.7
  #important as there is a bug related to nullables that have multiple
  #consquences: nullables anoying messages and overall impossibility
  # to run webdev or build_run
  analyzer: 0.39.14
  
#if error then try using buid_runner
flutter pub run build_runner build  --delete-conflicting-outputs 
flutter pub run build_runner serve [or watch]
