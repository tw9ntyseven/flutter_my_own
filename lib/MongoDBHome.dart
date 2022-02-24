// To parse this JSON data, do
//
//     final mongoDbModel = mongoDbModelFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbModelHome mongoDbModelHomeFromJson(String str) =>
    MongoDbModelHome.fromJson(json.decode(str));

String mongoDbModelHomeToJson(MongoDbModelHome data) =>
    json.encode(data.toJson());

class MongoDbModelHome {
  MongoDbModelHome({
    required this.id,
    required this.title,
    required this.subtitle,
    // required this.favorite,
  });

  ObjectId id;
  String title;
  String subtitle;
  // bool favorite;

  factory MongoDbModelHome.fromJson(Map<String, dynamic> json) =>
      MongoDbModelHome(
        id: json["_id"],
        title: json["title"],
        subtitle: json["subtitle"],
        // favorite: json["favorite"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "subtitle": subtitle,
        // "favorite": favorite,
      };
}
