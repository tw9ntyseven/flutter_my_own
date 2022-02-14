import 'dart:developer';

import 'package:flutter_my_own/MongoDBModel.dart';
import 'package:flutter_my_own/dbHelper/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }

// ?????????????????????????
  static Future<void> update(MongoDbModel data) async {
    var result = await userCollection.findOne({"_id": data.id});
    result['firstName'] = data.firstName;
    result['lastName'] = data.lastName;
    result['address'] = data.address;
    var response = await userCollection.save(result);
    inspect(response);
  }

  static delete(MongoDbModel user) async {
    await userCollection.remove(where.id(user.id));
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something Wrong while inserting data.";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
