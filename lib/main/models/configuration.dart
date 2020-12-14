import 'package:quiver/collection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:udoit/main/utils/waitfor.dart';
import 'dart:collection';

enum CategoryType { animales, politica }

class Category {
  CategoryType type;
  String name;
  String icon;

  Category({this.type, this.name, this.icon});

  @override
  String toString() {
    return "{type: $type, name: $name , icon: $icon}";
  }
}

class Categories {
  final DocumentReference _confDocRef;

  // constructor
  Categories(this._confDocRef);

  Future<List<Category>> loadFromFirestore() async {
    List<Category> _categories = <Category>[];
    await _confDocRef.get().then((value) {
      for (final cat in value.data()['categories']) {
        _categories.add(Category(name: cat['name'], icon: cat['icon']));
      }
    }).catchError((error) => print("...getting configuration: $error"));
    return _categories;
  }
}

class Configuration {
  Categories _categories;

  Future<List<Category>> get categories async {
    return _categories.loadFromFirestore();
  }

  Configuration({String version = 'v0.1'}) {
    //get categories
    _categories = Categories(
        FirebaseFirestore.instance.collection('configuration').doc(version));
  }
}
