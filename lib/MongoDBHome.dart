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
  });

  ObjectId id;
  String title;
  String subtitle;

  factory MongoDbModelHome.fromJson(Map<String, dynamic> json) =>
      MongoDbModelHome(
        id: json["_id"],
        title: json["title"],
        subtitle: json["subtitle"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "subtitle": subtitle,
      };
}
