import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../object/User.dart';
import '../pages/HomePage.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({Key? key}) : super(key: key);

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();
  final _myControllerEmail = TextEditingController();
  final _myControllerPassword = TextEditingController();
  late int code;
  late Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Spacer(flex: 1),
          const Text("Email"),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Entrez une valeur";
              }
              return null;
            },
            controller: _myControllerEmail,
          ),
          const Padding(padding: EdgeInsets.all(40)),
          const Text("mot de passe"),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Entrez une valeur";
              }
              return null;
            },
            controller: _myControllerPassword,
          ),
          const Padding(padding: EdgeInsets.all(20)),
          ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  http.Response response = await _getProfilInfos(
                      _myControllerEmail.text, _myControllerPassword.text);
                  map = convert.jsonDecode(response.body);
                  bool validCred = await _login(context);
                  if (!validCred) {
                    _createAlert(map['message']);
                  }
                }
              },
              child: const Text("Connexion")),
          const Spacer(
            flex: 4,
          )
        ],
      ),
    );
  }

  Future<http.Response> _getProfilInfos(String email, String password) async {
    return http.post(
      Uri.parse(
          'http://s3-4223.nuage-peda.fr/mesCompetences/api/authentication_token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert
          .jsonEncode(<String, String>{'email': email, 'password': password}),
    );
  }

  Future<bool> _login(BuildContext context) async {
    await _getProfilInfos(_myControllerEmail.text, _myControllerPassword.text);

    if (map['code'] != null) {
      return false;
    }

    print(map);

    User user = User(map[''], map['token']);




    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const MyHomePage(),
            settings: RouteSettings(arguments: user)));
    return true;
  }

  Future<void> _createAlert(String message) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erreur 401'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text("Login ou mot de passe incorrect."),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("Quitter"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
