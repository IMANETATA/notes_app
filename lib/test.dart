import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  File file;
  var imagepicker= imagepicker();
  uploadImages()async{
    var imagepicked= await imagepicker.getImage(source:ImageSource.camera);
    var nameimg= basename(imagepicked.path);



    //start upload

  var random=Random().nextInt(1000000);
  nameimg="$random$nameimg";
    var refstorage= FireBaseStorage.instance.ref('avatar/part1/$nameimg');
    await refstorage.putFile(file);
    var url=refstorage.getDownloadURL();
    print('url: $url');

    //end


    if(imagepicked!= null){
      file=File(imagepicked.path);
      print(imagepicked.path);

      //recupere le nom dimage

    }else{
      print('please choose image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('test'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(onPressed: ()async{
              await uploadImages();
            }, child: Text('uplaod image')),
          )

        ],
      )
    );
  }
}