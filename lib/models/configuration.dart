import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//enum CategoryType { animales, politica }

class Category {
  String id;
  String name;
  String iconUrl;
  Image iconImage;

  Category({this.id, this.name, this.iconUrl});

  @override
  String toString() {
    return "{id: $id, name: $name, iconUrl: $iconUrl}";
  }
}

class Configuration {
  String version;
  List<Category> categories = <Category>[];
  Map<String, String> defaultAvatars = Map<String, String>();

  Configuration({this.version = 'v0.1'});

  Future _loadCategoriesFromFirestore() async {
    await FirebaseFirestore.instance
        .collection('configuration')
        .doc(version)
        .get()
        .then((value) {
      for (final cat in value.data()['categories']) {
        categories.add(Category(
          name: cat['name'],
          id: cat['id'],
          iconUrl: cat['icon'],
        ));
      }
    }).catchError((error) => print("...getting configuration: $error"));
  }

  Future _loadDefaultAvatarsFromFirestore() async {
    await FirebaseFirestore.instance
        .collection('configuration')
        .doc(version)
        .get()
        .then((value) {
      defaultAvatars['boy'] = value.data()['login']['defaultAvatar']['boy'];
      defaultAvatars['girl'] = value.data()['login']['defaultAvatar']['girl'];
      defaultAvatars['man'] = value.data()['login']['defaultAvatar']['man'];
      defaultAvatars['woman'] = value.data()['login']['defaultAvatar']['woman'];
      defaultAvatars['undefined'] =
          value.data()['login']['defaultAvatar']['undefined'];
    }).catchError((error) => print("...getting configuration: $error"));
    return;
  }

  Future loadConfiguration() async {
    await _loadCategoriesFromFirestore();
    await _loadDefaultAvatarsFromFirestore();
  }
}
