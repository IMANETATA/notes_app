
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
//import 'package:geolocator/geolocator.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // ignore: prefer_typing_uninitialized_variables
  var myemail,mypassword;
  GlobalKey <FormState> formstate= GlobalKey<FormState>();

signIn()async{
 var formdata=formstate.currentState;
   if(formdata!.validate()){
    formdata.save();
    try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: myemail,
    password: mypassword
  );
  return credential;
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    AwesomeDialog (context:context,title:"error",body:const Text("no user found for this email")).show();
   
  } else if (e.code == 'wrong-password') {
    AwesomeDialog (context:context,title:"error",body:const Text("wrong password for that user")).show();
   
  }
}
   }else{
    print("not valid");
   }
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
        decoration: const InputDecoration(
          hintText: "enter your email",
          prefixIcon: Icon(Icons.person),
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
    const Text("if you have not account. "),
    InkWell(onTap: (){
      Navigator.of(context).pushNamed("signup");
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
  var user= await signIn();
  if(user != null){
Navigator.of(context).pushReplacementNamed("homepage");
  }

  },
   child: const Text("se connecter",
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
