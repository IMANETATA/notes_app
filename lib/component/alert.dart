import 'package:flutter/material.dart';
//loading while application is lanced
showLoading(context){
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text('please wait...'),
      content: Container(height:50,child: Center(child: CircularProgressIndicator())),
    );
  });
}