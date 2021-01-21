import 'package:flutter/material.dart';
import 'package:udoit/models/firestoreObject.dart';
import 'package:udoit/utils/hash.dart';

class Comment extends FirestoreObject {
  String id;
  String userId;
  DateTime dateTime;
  String text;
  int likes;

  Comment({this.id, this.userId, this.dateTime, this.text, this.likes}) {
    assert(userId != null);
    //id generated from user user uuid and dateTime
    /*this.id = generateMD5fromStringList(
        [this.dateTime.toIso8601String(), this.userId]);*/
  }

  @override
  void fromFirestoreDoc(dynamic doc) {
    Map<String, dynamic> data = doc.data();
    this.id = doc.id;
    this.userId = data['userId'];
    this.dateTime = DateTime.fromMicrosecondsSinceEpoch(
        data['dateTime'].microsecondsSinceEpoch);
    this.text = data['text'];
    this.likes = data['likes'];
  }

  @override
  Map<String, dynamic> asFirestoreData() {
    return {
      'userId': userId,
      'dateTime': dateTime,
      'text': text,
      'likes': likes,
    };
  }
}
