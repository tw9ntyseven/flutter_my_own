import 'package:flutter/material.dart';
import 'package:flutter_my_own/MongoDBHome.dart';
import 'package:flutter_my_own/Screens/card-view.dart';
import 'package:flutter_my_own/dbHelper/mongodbhome.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

enum WhyFarther { delete }

class _HomeState extends State<Home> {
  var title = new TextEditingController();
  var subtitle = new TextEditingController();
  bool favorite = false;

  var _like = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: MongoDatabaseHome.getDataHome(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                var totalData = snapshot.data.length;
                print("Total Data" + totalData.toString());
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return homeCard(
                          MongoDbModelHome.fromJson(snapshot.data[index]));
                    });
              } else {
                return Text("No contacts found");
              }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  insetPadding: EdgeInsets.all(15.0),
                  title: Text('Добавить заметку'),
                  content: SizedBox(
                    height: 250,
                    child: Column(
                      children: [
                        TextField(
                          maxLength: 25,
                          controller: title,
                          decoration: InputDecoration(labelText: "Титул"),
                        ),
                        TextField(
                          maxLines: null,
                          controller: subtitle,
                          decoration:
                              InputDecoration(labelText: "Текст заметки"),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        _insertData(title.text, subtitle.text);
                        setState(() {});
                      },
                      child: Text("Добавить"),
                    ),
                  ],
                );
              });
          setState(() {});
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }

  Widget homeCard(MongoDbModelHome data) {
    return SizedBox(
      height: double.infinity,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CardView(
                        cardTitle: data.title,
                        cardSubtitle: data.subtitle,
                      )));
        },
        child: Card(
          semanticContainer: true,
          // clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${data.title}",
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  Text("${data.subtitle}"),
                  Container(
                    width: 100,
                    child: Wrap(
                      children: [
                        IconButton(
                          onPressed: () async {
                            await MongoDatabaseHome.delete(data);
                            setState(() {});
                          },
                          color: Colors.redAccent,
                          icon: Icon(Icons.delete),
                        ),
                        IconButton(
                            onPressed: () {
                              // _likesCounter();
                            },
                            icon: Icon(Icons.favorite)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _likesCounter() {
    setState(() {
      _like++;
    });
  }

  // POST DATA
  Future<void> _insertData(String iTitle, String iSubtitle) async {
    var _id = M.ObjectId(); // unique id
    final data = MongoDbModelHome(id: _id, title: iTitle, subtitle: iSubtitle);
    var result = await MongoDatabaseHome.insert(data);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Inserted ID" + _id.$oid)));
    _clearAll();
  }

  void _clearAll() {
    title.text = "";
    subtitle.text = "";
  }
}
