 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/crud/editnotes.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  CollectionReference notesref= FirebaseFirestore.instance.collection("notes");
 /*List notes=[
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
*/

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
          actions: [
            IconButton(onPressed: ()async{
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('login');
            }, icon:const Icon(Icons.exit_to_app))
          ],
        ),
        floatingActionButton: FloatingActionButton(child: const Icon(Icons.add),onPressed: (){
          Navigator.of(context).pushNamed("addnotes");
        },),

        body: Container(
  margin: const EdgeInsets.all(0),
  child: FutureBuilder( // afficher les donnee de la note dan le homepgae
    future: notesref.where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, i) {
            return Dismissible(
              onDismissed: (direction)async{
              await  notesref.doc(snapshot.data!.docs[i].id).delete();
              await FirebaseStorage.instance.refFromURL(snapshot.data!.docs[i]['imageurl']).delete().then((value) {
                print("delete");
              } );
              },
              key: UniqueKey(), 
              child: ListNotes(
                notes: snapshot.data!.docs[i],
                docid:snapshot.data!.docs[i].id,));
           // return Text("${snapshot.data!.docs[i].data()?['title'] ?? 'N/A'}");
          //  return Text("${snapshot.data!.docs[i].data()['title']}");
            // return ListNotes(notes: notes[index]);
            // Utilisez la ligne ci-dessus si vous avez une classe ListNotes et souhaitez afficher des notes sous forme de widget.
          },
        );
      } 
        // Gérer le cas où les données ne sont pas encore disponibles
        return const Center(child:  CircularProgressIndicator());
      
    },
  ),
),
        /*body: Container(
          margin:const EdgeInsets.all(0),
          child: FutureBuilder(
            future : notesref.where("userid",isEqualTo: FirebaseAuth.instance.currentUser!.uid ).get(), 
            builder: (context,snapshot){
              if(snapshot.hasData){
                return  ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: ( context,  i ) {
              
              return Text("${snapshot.data!.docs[i].data()!['title']}");// ListNotes(notes:notes[index] ,) ;//class
            },
          );
              }
            }
            )
        ),*/
        
    );
  }
}
class ListNotes extends StatelessWidget {
  

  //const listNotes({super.key});
// ignore: prefer_typing_uninitialized_variables
        final notes;
        final docid;


        ListNotes({super.key, this.notes,this.docid});
  @override
 
  Widget build(BuildContext context) {
    return Card(child:
    Row(children: [
      Expanded(
        flex: 1,
        child: Image.network("${notes['imageurl']}",fit: BoxFit.fill,height:100 ,)
      ) ,
      Expanded(
        flex: 3,
        child: ListTile(
        title: Text("${notes['title']}"),
        subtitle: Text("${notes['note']}"),
        trailing: IconButton(onPressed: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return EditNotes(docid:docid ,list: notes,);
      }));
        }, icon:const Icon(Icons.edit)),
        
          ),
      ) , 
      
    ],)
    )
    ;
  }
}
