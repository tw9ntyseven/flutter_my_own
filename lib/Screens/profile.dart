import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String _mail = "neloginon@yandex.ru";
    String _name = "Vlad Milicin";
    String _avatar = "lib/Assets/d224f6032965e65374fd0635631245bf.jpeg";

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 25.0)),
            CircleAvatar(radius: 60, backgroundImage: AssetImage(_avatar),),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            Text(_name, style: TextStyle(fontSize: 24)),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(Icons.mail_outline, size: 15,),
                Padding(padding: EdgeInsets.only(left: 5.0)),
                Text(_mail, style: TextStyle(fontSize: 16),),
              ],
            )
          ],
        ),
      ),
    );
  }
}