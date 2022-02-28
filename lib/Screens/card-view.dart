import 'package:flutter/material.dart';
import 'package:flutter_my_own/dbHelper/mongodbhome.dart';

import '../MongoDBHome.dart';

class CardView extends StatefulWidget {
  final String cardTitle;
  String cardSubtitle;

  CardView({
    Key? key,
    required this.cardTitle,
    required this.cardSubtitle,
  }) : super(key: key);

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    var notes = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cardTitle),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: (text) {},
              // initialValue: 'hello',
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey)),
                hintText: widget.cardSubtitle,
              ),
              maxLines: 30,
              controller: notes,
              // decoration: InputDecoration(labelText: cardSubtitle),
            ),
            // Text(deleteCard),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await MongoDatabaseHome.delete();

          setState(() {});
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
