// ignore_for_file: slash_for_doc_comments

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

          //text field pour l'email, lorsqu'il est validé il y a une vérification de nullité 
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

          //text field pour le mot de passe, lorsqu'il est validé il y a une vérification de nullité 
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
            /**
             * Bouton de connexion
             * Si le formulaire est validé
             * j'appel la fonction _getProfilInfos
             * la variable map reçoit la conversion du résultat de _getProfilInfos
             * 
             * le booléen validCred reçoit le résultat de _login
             * si validCred est faux 
             *  alors 
             *    - je lance la fonction _createAlert     
             * 
             */
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

  /**
   * Fonction d'accès aux données utilisateurs via API
   * je me connecte à l'API donnée avec les identifiants fournis.   
   */

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

  /**
   * Fonction de login
   * j'attends le retour de la fonction _getProfilInfos
   * si le code retourné est différent de null 
   *  alors
   *    - je retourne null
   * sinon
   *    - je crée un User avec les infos retourné
   *    - je pousse une nouvelle page avec comme arguments l'utilisateur
   */
  Future<bool> _login(BuildContext context) async {
    await _getProfilInfos(_myControllerEmail.text, _myControllerPassword.text);

    if (map['code'] != null) {
      return false;
    }


    User user = User(map['id'].toString(),map['nom'].toString(), map['token'].toString(), map['roles'].toString());


    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(),
            settings: RouteSettings(arguments: user)));
    return true;
  }

  /**
   * Fonction de création d'alerte.
   * Je retourne une alerte en cas d'erreur 401
   * Login ou mot de passe incorrect 
   */

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