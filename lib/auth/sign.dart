
// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
//import 'package:geolocator/geolocator.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

 // ignore: prefer_typing_uninitialized_variables
 var myusername,myemail,mypassword;
  GlobalKey <FormState> formstate= GlobalKey<FormState>();
 Future<UserCredential?> signUp()async{
    var formdata=formstate.currentState;
    if(formdata!.validate()){
formdata.save();//chaque valeur se stockent dans son propre champs
try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: myemail,
    password: mypassword,
  );
  return credential;
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    AwesomeDialog (context:context,title:"error",body:const Text("pass too weak")).show();
   
  } else if (e.code == 'email-already-in-use') {
    AwesomeDialog (context:context,title:"error",body:const Text("the account already exist")).show();
   
  }
} catch (e) {
  print(e);
}
    }else{
      
    }
   // return null ;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
     body: Column( mainAxisAlignment:MainAxisAlignment.center,
      children: [const Center(  child:CircleAvatar(backgroundImage: AssetImage("images/ca.png"),radius: 50,),),
    Container(
      padding:const EdgeInsets.all(20),
      child:Form(
        key: formstate,
        child:Column(children: [
 TextFormField(
  onSaved:(val){
    myusername=val;
  } ,//stocker la valeur apres validation
  validator: (val){//verifier les champs mettre des condition
    if(val!.length>100){
return "username cant be larger than 100 caractere";
    }
     if(val.length<2){
return "username cant be less than 2 caractere";
    }
    return null;
  },
        decoration: const InputDecoration(
          hintText: "enter your username",
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(borderSide: BorderSide(width: 1))
        ) ,
 ),const SizedBox(height: 20),
 TextFormField(
   onSaved:(val){
    myemail=val;
  } ,
  validator: (val){
    if(val!.length>100){
return "email cant be larger than 100 caractere";
    }
     if(val.length<2){
return "email cant be less than 2 caractere";
    }
    return null;
  },
        decoration:const  InputDecoration(
          
          hintText: "enter your email",
          prefixIcon: Icon(Icons.email),
          border: OutlineInputBorder(borderSide: BorderSide(width: 1))
        ) ,
 ),
const SizedBox(height: 20),
 TextFormField(
   onSaved:(val){
    mypassword=val;
  } ,
  validator: (val){
    if(val!.length>100){
return "password cant be larger than 100 caractere";
    }
     if(val.length<2){
return "password cant be less than 2 caractere";
    }
    return null;
  },
  obscureText: true,
        decoration:const  InputDecoration(
          
          hintText: "enter your password",
          prefixIcon: Icon(Icons.key),
          border: OutlineInputBorder(borderSide: BorderSide(width: 1))
        ) ,
 ),
 Container( padding: const EdgeInsets.all(10),
  child: Row(
  children: [
    const Text("if you have  account. "),
    InkWell(onTap: (){
      Navigator.of(context).pushNamed("login");
    },
      child:const  Text("click here",style: TextStyle(color: Colors.blue,),),)
  ],
 ),)
 ,
 Container(
  margin:const EdgeInsets.all(5),
  child: 
 ElevatedButton(
  style: ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.amber,
  ),
  onPressed: ()async{
  UserCredential? response=  await signUp();
  
  if(response!=null){
    Navigator.of(context).pushReplacementNamed("homepage");
  }else{
    print("sign up failed");
  }
  

//Navigator.of(context).pushNamed("homepage");
  },
   child: const Text("sign up",
   style:
   //Theme.of(context).textTheme.headlineSmall,
   TextStyle(fontSize: 20) ,),
   
  )
 ,)
      ],
       ) )
    )
   
     ]),
    );
  }
}
