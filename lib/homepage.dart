import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:modelnoteapp/textnote.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fullnote.dart';
import 'notemodel.dart';

class homepage extends StatefulWidget {
  final note;

  const homepage({required this.note, super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<String> oldnotes = [];

  getdata() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    List<String> notes = pre.getStringList('mynotes') ?? [];

    setState(() {
      oldnotes = notes;
    });

  }
  void removedata(int i) async {
    final SharedPreferences pre = await SharedPreferences.getInstance();
    oldnotes.removeAt(i);
    pre.setStringList('mynotes',oldnotes );
    getdata();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('All notes')),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 8.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ),
        padding: EdgeInsets.all(8.0), // padding around the grid
        itemCount: oldnotes.length, // total number of items
        itemBuilder: (context, index) {

          Note note=Note.fromMap(jsonDecode(oldnotes[index]));
          print(oldnotes[index]);

          return InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>fullnote(note:note)));
            },
            child: Container(
              color: Colors.teal, // color of grid items
              child: Stack(children: [
                Positioned(
                    right: 10,
                    top: 10,
                    child: CircleAvatar(
                        radius: 15,
                        child: IconButton(
                          onPressed: () {
                             removedata(index);
                          },
                          icon: Icon(
                            Icons.close,
                            size: 15,
                          ),
                        ))),
                Positioned(
                  child: Column(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width/2,
                        child: Text(
                          note.Title.toString(),
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width/2,
                        child: Text(
                          note.Subtitle.toString(),
                          style: TextStyle(fontSize: 18.0, color: Colors.black54),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            note.Date.toString(),
                            style: TextStyle(
                                fontSize: 18.0, color: Colors.black54),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            note.Time.toString(),
                            style: TextStyle(
                                fontSize: 18.0, color: Colors.black54),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => textnote()));
        },
        child: Icon(
          Icons.add,
        ),
        shape: CircleBorder(),
        backgroundColor: Colors.green,
      ),
    );
  }
}
