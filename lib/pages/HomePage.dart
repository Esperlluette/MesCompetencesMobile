import 'package:flutter/material.dart';
import 'package:mescompetences/component/FormLogin.dart';
import 'package:mescompetences/object/User.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("data")),
    );
  }
}