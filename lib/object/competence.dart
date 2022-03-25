// ignore_for_file: file_names, recursive_getters

import 'dart:convert';

class competence {
  int _id;
  String _libelle;

  competence(this._id, this._libelle);

  competence.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _libelle = json['libelle'];

  int get id => this._id;
  set id(int value) => this._id = value;

  get libelle => _libelle;
  set libelle(value) => _libelle = value;
}
