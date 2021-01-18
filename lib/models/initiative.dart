import 'package:flutter/material.dart';
import 'package:udoit/utils/hash.dart';

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

class Initiative {
  String publisherUserId;
  String id;
  DateTime dateTime;
  Category category;
  String title;
  String destinatary;
  String summary;
  String request;
  List<dynamic> uint8images;
  List<String> imagesUrls = [];
  String youtubeVideoUrl;
  int likes;
  int shared;
  int subscribers;
  int subcribersCommitted;
  int usersWithComments;
  int viewers;

  Initiative(
      {this.publisherUserId,
      this.dateTime,
      this.category,
      this.title,
      this.destinatary,
      this.summary,
      this.request,
      this.uint8images,
      this.youtubeVideoUrl}) {
    assert(publisherUserId != null);
    //id generated from user user uuid and dateTime
    this.id = generateMD5fromStringList(
        [this.dateTime.toIso8601String(), this.publisherUserId]);
  }

  Initiative.fromJSON(Map<String, dynamic> data) {
    this.publisherUserId = data['publisherUserId'];
    this.dateTime = DateTime.fromMicrosecondsSinceEpoch(
        data['dateTime'].microsecondsSinceEpoch);
    this.category = Category(id: data['category']);
    this.title = data['title'];
    this.destinatary = data['destinatary'];
    this.summary = data['summary'];
    this.request = data['request'];
    this.imagesUrls = List<String>.from(data['imagesUrls']);
    //this.uint8images = data['uint8images'];
    this.youtubeVideoUrl = data['youtubeVideoUrl'];
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'publisherUserId': publisherUserId,
      'dateTime': dateTime,
      'category': category.id,
      'title': title,
      'destinatary': destinatary,
      'summary': summary,
      'request': request,
      'imagesUrls': imagesUrls,
      'youtubeVideoUrl': youtubeVideoUrl,
    };
  }
}
