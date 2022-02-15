import 'dart:developer';

import 'package:flutter_my_own/MongoDBHome.dart';
import 'package:flutter_my_own/dbHelper/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabaseHome {
  static var db, homeCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    homeCollection = db.collection(HOME_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getDataHome() async {
    final arrDataHome = await homeCollection.find().toList();
    return arrDataHome;
  }

// ?????????????????????????
  static Future<void> update(MongoDbModelHome data) async {
    var result = await homeCollection.findOne({"_id": data.id});
    result['firstName'] = data.title;
    result['lastName'] = data.subtitle;
    var response = await homeCollection.save(result);
    inspect(response);
  }

  static delete(MongoDbModelHome user) async {
    await homeCollection.remove(where.id(user.id));
  }

  static Future<String> insert(MongoDbModelHome data) async {
    try {
      var result = await homeCollection.insertOne(data.toJson());
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
