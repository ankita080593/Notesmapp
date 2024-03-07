import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';
import 'notemodel.dart';

class textnote extends StatefulWidget {
  const textnote({super.key});

  @override
  State<textnote> createState() => _textnoteState();
}

class _textnoteState extends State<textnote> {
  TextEditingController titlecontoller = TextEditingController();
  TextEditingController typetext = TextEditingController();
  DateTime datetime = DateTime.now();
  String formattedDate = DateFormat.MMMMd().format(DateTime.now());
  String formattedTime = DateFormat.jm().format(DateTime.now());

  void savedata() async {
    SharedPreferences pre = await SharedPreferences.getInstance();

    String title = titlecontoller.text;
    String Starttype = typetext.text;

    if (title != '' && Starttype != '') {
      List<String> oldnotes = pre.getStringList('mynotes') ?? [];
      
      Note note = Note(
        Title: title,
        Subtitle: Starttype,
        Date: formattedDate,
        Time: formattedTime,
      );
      oldnotes.add(note.toJson());
      pre.setStringList('mynotes',oldnotes );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => homepage(note: note,),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            savedata();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => homepage(note: '')));
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
              onPressed: () {
                savedata();
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: titlecontoller,
              decoration:
                  InputDecoration(hintText: 'Title', border: InputBorder.none),
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width / 1.13,
              child: Text('$formattedDate  $formattedTime')),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: typetext,
              decoration: InputDecoration(
                  hintText: 'Start Typing', border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }
}
