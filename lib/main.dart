import 'package:flutter/material.dart';
import 'package:flutter_my_own/Screens/app.dart';
import 'package:flutter_my_own/Screens/card-view.dart';
import 'package:flutter_my_own/dbHelper/mongodb.dart';
import 'package:flutter_my_own/dbHelper/mongodbhome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  await MongoDatabaseHome.connect();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.black45,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => App(),
      '/card-view': (context) => CardView(
            cardTitle: '',
            cardSubtitle: '',
          ),
      // '/todo': (context) => Home(),
    },
  ));
}
