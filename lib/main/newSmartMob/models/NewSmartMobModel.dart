import 'package:udoit/main/newSmartMob/NewSmartMob.dart';
import 'package:udoit/main/utils/globals.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewSmartMobData {
  DateTime dateTime;
  String category;
  String title;
  String destinatary;
  String request;

  List images = new List();
  List video = new List();

  NewSmartMobData(
      {this.dateTime,
      this.category,
      this.title,
      this.destinatary,
      this.request});

  Future<void> WriteToFirestore() async {
    CollectionReference newSmartMobs =
        FirebaseFirestore.instance.collection('newSmartMobs');
    return newSmartMobs
        .add({
          'dateTime': Timestamp.fromDate(dateTime),
          'category': category,
          'title': title,
          'destinatary': destinatary,
          'request': request,
        })
        .then((value) => print("... newSmartMobs added"))
        .catchError((error) => print("... newSmartMobs added: $error"));
  }
}

final List<String> categoriesImages = [
  'assets/categories/animales.png',
  'assets/categories/derechosDeLasMujeres.png',
  'assets/categories/derechosHumanos.png',
  'assets/categories/justiciaEconomica.png',
  'assets/categories/justiciaPenal.png',
  'assets/categories/medioAmbiente.png',
  'assets/categories/salud.png',
  'assets/categories/tuBarrio.png'
];

final List<String> categoriesNames = [
  'animales',
  'derechosDeLasMujeres',
  'derechosHumanos',
  'justiciaEconomica',
  'jusiticiaPenal',
  'medioAmbiente',
  'salud',
  'tuBarrio'
];
