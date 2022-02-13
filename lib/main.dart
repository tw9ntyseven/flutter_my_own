import 'package:flutter/material.dart';
import 'package:flutter_my_own/Screens/app.dart';
import 'package:flutter_my_own/dbHelper/mongodb.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();

  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.black45,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => App(),
      // '/todo': (context) => Home(),
    },
  ));
}
