import 'package:flutter/material.dart';
import 'package:mescompetences/component/FormLogin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyMainPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyMainPage extends StatefulWidget {
  const MyMainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FormLogin(),
        );
  }
}
