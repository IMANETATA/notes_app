import 'package:flutter/material.dart';

class ViewNotes extends StatefulWidget {
  final notesv;
   ViewNotes({Key? key, this.notesv}) : super(key: key);

  @override
  State<ViewNotes> createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text('View notes'),
      ),
      body:  Container(
        margin: const EdgeInsets.all(0),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.all(0),
            child: Image.network("${widget.notesv['imageurl']}",
          width: double.infinity,
          height: 300,
          fit: BoxFit.fill,
          ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Text("${widget.notesv['title']}",style:const TextStyle(fontSize: 30,color: Colors.blue),)),
             Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Text("${widget.notesv['note']}",style:const TextStyle(fontSize: 20),)),
        ]) ,
      ),
    );
  }
}