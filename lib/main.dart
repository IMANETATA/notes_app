import 'package:notes_app/crud/addnotes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth/login.dart';
import 'auth/sign.dart';
import 'home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';

late bool isLogin;
  void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // var user= FirebaseAuth.instance.currentUser;
   /*if(user==null){
    isLogin=false;
   }else{
    isLogin=true;
   }*/
   // options: DefaultFirebaseOptions.currentPlatform,
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        textTheme:const TextTheme(
          titleLarge: TextStyle(fontSize: 20,color: Colors.white)
        )),
        
      home: HomePage(),
      routes: {
        "login": (context)=>const Login(),
        "signup":(context)=>const SignUp(),
        "homepage":(context) => const HomePage(),
        "addnotes" :(context) =>const AddNotes()
      },
    );
  }
}
/*
class Home extends StatelessWidget{
  const Home({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar( ),
      drawer:const Drawer(),
     body:Column(
      children: [
        ElevatedButton(onPressed: (){


        }, child: const Text("sign in"))
      ],
     )
     
    ); 
}}
*/
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( ),
      drawer:const Drawer(),
     body:Column(
      children: [
        ElevatedButton(onPressed: ()async{
 UserCredential cred= await signInWithGoogle();
 print(cred);
        }, child: const Text("sign in"))
      ],
     ));
  }
}