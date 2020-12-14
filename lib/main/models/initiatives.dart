import 'package:udoit/main/models/configuration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Initiative {
  String name = "";
  String duration = "";
  Category category;
  String description = "";
  String icon = "";

  Initiative(
      {this.name, this.duration, this.category, this.description, this.icon});

  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'duration': duration,
      'category': category.type.toString(),
      'description': description,
      'icon': icon
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
