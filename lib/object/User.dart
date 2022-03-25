// ignore_for_file: file_names

import 'competence.dart';

class User {
  late String _name;
  late String _token;
  // late String _role;
  late List<competence?> _competences;

  User(this._name, this._token);

  String get name => this._name;
  set name(value) => this._name = value;

  get token => this._token;
  set token(value) => this._token = value;

  // get role => this._role;
  // set role(value) => this._role = value;

}
