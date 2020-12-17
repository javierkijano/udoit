import 'package:udoit/main/models/configuration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Initiative {
  DateTime dateTime;
  Category category;
  String title;
  String destinatary;
  String request;

  Initiative(
      {this.dateTime,
      this.category,
      this.title,
      this.destinatary,
      this.request});

  Map<String, dynamic> toJSON() {
    return {
      'dateTime': dateTime,
      'category': category.type,
      'title': title,
      'destinatary': destinatary,
      'request': request
    };
  }
}

class Initiatives {
  CollectionReference _ref;

  Initiatives() {
    _ref = FirebaseFirestore.instance.collection('initiatives');
  }

  Future add(Initiative initiative) async {
    return await _ref.add(initiative.toJSON()).then((value) {
      int a = 0;
    }).catchError((error) => print("...: $error"));
  }

  latest() {}

  popular() {}

  trending() {}
}
