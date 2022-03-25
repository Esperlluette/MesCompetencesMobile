// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../object/User.dart' show User;

class MyHomePage extends StatelessWidget {
  MyHomePage({ Key? key }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    final _user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(title: Text(_user.name)),
    );
  }
}