import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 List notes=[
  {"note":"i am programmer",
  "image":"a(2).png"
  },
  {"note":"i am programmer1",
  "image":"a(2).png"
  },
  {"note":"i am programmer2",
  "image":"a(2).png"
  },
  {"note":"i am programmer3",
  "image":"a(2).png"
  }
 ];

 
//recuperer les donnees du dernier personne connecte 
 getUser(){
  var user=FirebaseAuth.instance.currentUser;
  print(user!.email);
 }
 @override
  void initState() {
    getUser();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
        appBar: AppBar(
          title:const Text("home page"),
        ),
        floatingActionButton: FloatingActionButton(child: const Icon(Icons.add),onPressed: (){
          Navigator.of(context).pushNamed("addnotes");
        },),
        body: Container(
          margin:const EdgeInsets.all(0),
          child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              //-----swip pour supprimer les notes-----
              return Dismissible(key: Key("$index"), child:ListNotes(notes:notes[index]) ) ;// ListNotes(notes:notes[index] ,) ;//class
            },
          ),
        ),
        
    );
  }
}
class ListNotes extends StatelessWidget {
  

  //const listNotes({super.key});
// ignore: prefer_typing_uninitialized_variables
final notes;

const ListNotes({super.key, this.notes});
  @override
 
  Widget build(BuildContext context) {
    return Card(child:
    Row(children: [
      Expanded(
        flex: 1,
        child: Image.asset("images/a(2).png",fit: BoxFit.fill,height:100 ,)
      ) ,
      Expanded(
        flex: 3,
        child: ListTile(
        title:const Text("titre"),
        subtitle: Text("${notes["note"]}"),
        trailing: IconButton(onPressed: (){
      
        }, icon:const Icon(Icons.edit)),
        
          ),
      ) , 
      
    ],)
    )
    ;
  }
}
