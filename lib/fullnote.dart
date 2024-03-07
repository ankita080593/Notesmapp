import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'homepage.dart';
class fullnote extends StatefulWidget {
  final note;
  const fullnote({required this.note,super.key});

  @override
  State<fullnote> createState() => _fullnoteState();
}

class _fullnoteState extends State<fullnote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => homepage(note: '',)));
        },
        icon: Icon(Icons.arrow_back),
      ),

    ),
      body: Column(
        children: [
          SizedBox(width: MediaQuery.of(context).size.width / 1.13,
              child: Text(widget.note.Title.toString())),
          SizedBox(
              width: MediaQuery.of(context).size.width / 1.13,
              child: Text(widget.note.Subtitle.toString())),
          Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(widget.note.Date.toString()),
                  Text(widget.note.Time.toString())
                ],
              )
          )
        ],
      ),);
  }
}
