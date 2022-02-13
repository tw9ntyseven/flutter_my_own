import 'package:flutter/material.dart';
import 'package:flutter_my_own/MongoDBModel.dart';
import 'package:flutter_my_own/dbHelper/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // controllers
  var fnameController = new TextEditingController();
  var lnameController = new TextEditingController();
  var addressController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: MongoDatabase.getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                var totalData = snapshot.data.length;
                print("Total Data" + totalData.toString());
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return homeCard(
                          MongoDbModel.fromJson(snapshot.data[index]));
                    });
              } else {
                return Center(
                  child: Text("No Data Available."),
                );
              }
            }
          },
        ),
      ),
      // body: ListView.builder(
      //     itemCount: _todoList.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       return Dismissible(
      //           key: Key(_todoList[index]),
      //           child: Card(
      //             child: ListTile(
      //               title: Text(_todoList[index]),
      //               trailing: IconButton(
      //                 icon: Icon(Icons.highlight_remove_rounded),
      //                 color: Colors.red,
      //                 onPressed: () {
      //                   setState(() {
      //                     _todoList.removeAt(index);
      //                   });
      //                 },
      //               ),
      //             ),
      //           ),
      //           onDismissed: (directions) {
      //             setState(() {
      //               _todoList.removeAt(index);
      //             });
      //           });
      //     }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  insetPadding: EdgeInsets.all(15.0),
                  title: Text('Add Contact'),
                  content: Column(
                    children: [
                      TextField(
                        controller: fnameController,
                        decoration: InputDecoration(labelText: "First Name"),
                      ),
                      TextField(
                        controller: lnameController,
                        decoration: InputDecoration(labelText: "Last Name"),
                      ),
                      TextField(
                        controller: addressController,
                        decoration: InputDecoration(labelText: "Address"),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        _insertData(fnameController.text, lnameController.text,
                            addressController.text);
                        setState(() {});
                      },
                      child: Text("Add"),
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

  Widget homeCard(MongoDbModel data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.person,
              color: Colors.blueAccent,
            ),
            Padding(padding: EdgeInsets.only(right: 5.0)),
            Text("${data.firstName}"),
            Padding(padding: EdgeInsets.only(right: 3.0)),
            Text("${data.lastName}"),
            Padding(padding: EdgeInsets.only(right: 5.0)),
            Text("${data.address}"),
            IconButton(
              onPressed: () async {
                print(data.id);
                await MongoDatabase.delete(data);
                setState(() {});
              },
              color: Colors.redAccent,
              icon: Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }

  // POST DATA
  Future<void> _insertData(String fName, String lName, String address) async {
    var _id = M.ObjectId(); // unique id
    final data = MongoDbModel(
        id: _id, firstName: fName, lastName: lName, address: address);
    var result = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Inserted ID" + _id.$oid)));
    _clearAll();
  }

  void _clearAll() {
    fnameController.text = "";
    lnameController.text = "";
    addressController.text = "";
  }
}
