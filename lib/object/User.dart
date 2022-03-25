// ignore_for_file: file_names

import 'competence.dart';

class User {
  late String _id;
  late String _name;
  late String _token;
  late String _role;
  late List<competence?> _competences;

  User(this._id, this._name, this._token, this._role);

  String get id => this._id;
  set id(value) => this._id = value;

  String get name => this._name;
  set name(value) => this._name = value;

  String get token => this._token;
  set token(value) => this._token = value;

  String get role => this._role;
  set role(value) => this._role = value;

}