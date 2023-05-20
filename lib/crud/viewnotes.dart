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
        child:const Column(children: [
          
        ]) ,
      ),
    );
  }
}