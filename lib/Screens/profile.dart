import 'package:flutter/material.dart';
import 'package:flutter_my_own/MongoDBModel.dart';
import 'package:flutter_my_own/dbHelper/mongodb.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: profile(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  insetPadding: EdgeInsets.all(15.0),
                  title: Text('Edit Profile'),
                  content: SizedBox(
                    height: 250,
                    child: Column(
                      children: [
                        TextField(
                          maxLength: 10,
                          // controller: fnameController,
                          decoration: InputDecoration(labelText: "First Name"),
                        ),
                        TextField(
                          maxLength: 10,
                          // controller: lnameController,
                          decoration: InputDecoration(labelText: "Last Name"),
                        ),
                        TextField(
                          maxLength: 10,
                          // controller: addressController,
                          decoration: InputDecoration(labelText: "Address"),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text("Add"),
                    ),
                  ],
                );
              });
        },
        child: Icon(Icons.edit),
        backgroundColor: Colors.black,
      ),
    );
  }

  Widget profile() {
    String _mail = "neloginon@mail.ru";
    String _name = "VLADISLAV";
    String _avatar = "lib/Assets/d224f6032965e65374fd0635631245bf.jpeg";
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 25.0)),
        CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage(_avatar),
        ),
        Padding(padding: EdgeInsets.only(top: 15.0)),
        Text(_name, style: TextStyle(fontSize: 24)),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(
              Icons.mail_outline,
              size: 15,
            ),
            Padding(padding: EdgeInsets.only(left: 5.0)),
            Text(
              _mail,
              style: TextStyle(fontSize: 16),
            ),
          ],
        )
      ],
    );
  }
}
