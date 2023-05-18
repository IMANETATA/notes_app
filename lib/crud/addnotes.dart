import 'dart:math';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app/component/alert.dart';
import 'package:path/path.dart' ;
//as path
class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {

      CollectionReference notesref= FirebaseFirestore.instance.collection("notes");
      late Reference ref;
      late File file;
      var title,note,imageurl;


GlobalKey<FormState> formstate=  GlobalKey<FormState>();


//ajouter la note dans la base
      addNotes() async{
        if(file== null){ // if he dosnt choose an image
          return AwesomeDialog(context: this.context,
          title:'important',
          body:  Text
          
          )
        }
        var formdata = formstate.currentState;
        if(formdata!.validate()){
          showLoading(context);
          formdata.save();
          await ref.putFile(file);
        imageurl = await ref.getDownloadURL();
          await notesref.add({
            "title": title,
            "note": note,
            "imageurl":imageurl,
            "userid":FirebaseAuth.instance.currentUser!.uid //recuperer luser actuel connecte 
        });
        
        Navigator.of(this.context).pushNamed("homepage");
        }
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text("add note"),
      ),
      body:  Container(
        padding:const EdgeInsets.all(0),
        child:Column(children: [
          Form(
            key:formstate ,
            child: Column(
            children: [
              TextFormField(
                          validator: (val){
              if(val!.length>30){
          return "title cant be larger than 30 caractere";
              }
              if(val.length<2){
          return "title cant be less than 2 caractere";
              }
              return null;
            },
                onSaved: (val){
                  title=val;
                },
                maxLength: 30,
                decoration:const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "title note",
                  prefixIcon: Icon(Icons.note)
                ),
              ),
               TextFormField(
                            validator: (val){
                if(val!.length>255){
            return "note cant be larger than 255 letter";
                }
                if(val.length<10){
            return "note cant be less than 10 letter";
                }
                return null;
              },  
                 onSaved: (val){
                  note=val;
                },
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
                 showBottomModel(context);
              },
            // style:ButtonStyle(backgroundColor: Colors) ,
               child: 
             const  Text("add image")
              ),
               ElevatedButton(
               
                onPressed: ()async{
                 await addNotes();
                },
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
  showBottomModel(context){
    return showModalBottomSheet(context: context, builder: (context)=>Container(
      padding:const EdgeInsets.all(20),
      height: 200,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       const Text("choose image",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
        InkWell(onTap: ()async{

         var  picked= await ImagePicker().getImage(source:ImageSource.gallery);
        if(picked!=null){

          file=File(picked.path);
          var  rand= Random().nextInt(100000);
          var imagename = "$rand" + basename(picked.path);
          //var ref= 
        FirebaseStorage.instance.ref("images").child("$imagename"); 
        Navigator.of(context).pop();

        }
          
          //var  picked= await ImagePicker().getImage(source:ImageSource.gellery);
        },
          child: Container(padding:const EdgeInsets.all(10),width: double.infinity,
           child:const Row(
            children: [
              Icon(Icons.photo,size: 30,),
              SizedBox(width: 20,),
              Text("from gellery",style: TextStyle(fontSize: 20)),
            ],
          ))),
        InkWell(onTap: ()async{
          //search for image picker to add images oin db ???
         /* final ImagePicker picker = ImagePicker();
          final XFile? picked = await picker.pickImage(source: ImageSource.camera);
          if(picker!=null){
           file=File(picker.path);
           var rand =Random().nextInt(100000);
            var nameimage= basename(picker.path);
          }else
          {

          }*/
        var  picked= await ImagePicker().getImage(source:ImageSource.camera);
        if(picked!=null){

          file=File(picked.path);
          var  rand= Random().nextInt(100000);
          var imagename = "$rand" + basename(picked.path);
       //var ref= 
        FirebaseStorage.instance.ref("images").child("$imagename"); 
       Navigator.of(context).pop();
      
        }
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
 
       // }else{