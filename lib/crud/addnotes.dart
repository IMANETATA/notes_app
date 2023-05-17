import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text("add note"),
      ),
      body:  Container(
        padding:const EdgeInsets.all(0),
        child:Column(children: [
          Form(child: Column(
            children: [
              TextFormField(
                maxLength: 30,
                decoration:const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "title note",
                  prefixIcon: Icon(Icons.note)
                ),
              ),
               TextFormField(
                maxLength: 16787,
                minLines: 1,
                decoration:const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "write note",
                  prefixIcon: Icon(Icons.text_decrease)
                ),
              ),
              ElevatedButton(onPressed: (){
                 showBottomModel();
              },
            // style:ButtonStyle(backgroundColor: Colors) ,
               child: 
             const  Text("add image")
              ),
               ElevatedButton(
               
                onPressed: (){},
            // style:ButtonStyle(backgroundColor: Colors) ,
               child: 
              const Text("save")
              )
            ],
          ))
        ],)
      ),
    );
  }
  showBottomModel(){
    return showModalBottomSheet(context: context, builder: (context)=>Container(
      padding:const EdgeInsets.all(20),
      height: 200,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       const Text("choose image",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
        InkWell(onTap: (){

        },
          child: Container(padding:const EdgeInsets.all(10),width: double.infinity,
           child:const Row(
            children: [
              Icon(Icons.photo,size: 30,),
              SizedBox(width: 20,),
              Text("from gellery",style: TextStyle(fontSize: 20)),
            ],
          ))),
        InkWell(onTap: (){

        },
          child: Container(padding:const EdgeInsets.all(10),width: double.infinity,
           child:const Row(
            children: [
              Icon(Icons.camera_alt,size: 30,),
              SizedBox(width: 20,),
              Text("from camera",style: TextStyle(fontSize: 20)),
            ],
          ))),
      ],
    ),
    ));
  }
}