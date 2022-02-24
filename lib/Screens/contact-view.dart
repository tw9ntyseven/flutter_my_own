import 'package:flutter/material.dart';

class ContactView extends StatelessWidget {
  final String contactfName;
  final String contactlName;
  final String contactPhone;
  ContactView(
      {Key? key,
      required this.contactfName,
      required this.contactlName,
      required this.contactPhone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fName = new TextEditingController();
    var lName = new TextEditingController();
    var phone = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('${contactfName} ${contactlName}'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Padding(padding: EdgeInsets.only(top: 200.0)),
            Text(
              'Изменить контакт',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            TextField(
              controller: fName,
              decoration: InputDecoration(labelText: contactfName),
            ),
            TextField(
              controller: lName,
              decoration: InputDecoration(labelText: contactlName),
            ),
            TextField(
              controller: phone,
              decoration: InputDecoration(labelText: contactPhone),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {},
        child: Icon(Icons.save),
      ),
    );
  }
}
