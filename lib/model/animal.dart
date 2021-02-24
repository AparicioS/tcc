import 'package:cloud_firestore/cloud_firestore.dart';

class Animal {
  String name;
  String nBrinco;
  String sexo;
  DateTime dataNascimento;
  String raca;

  Animal(this.name, this.nBrinco, this.sexo, this.dataNascimento, this.raca);

  Animal.recenNascido(
    this.name,
    this.nBrinco,
    this.sexo,
    this.raca,
  ) {
    this.dataNascimento = DateTime.now();
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['nBrinco'] = nBrinco;
    map['nome'] = name;
    map['sexo'] = sexo;
    map['data_de_nascimento'] = dataNascimento;
    map['raca'] = raca;

    return map;
  }

  Animal.fromDoc(QueryDocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data();
    this.nBrinco = doc.id;
    this.name = map['nome'];
    this.sexo = map['sexo'];
    this.dataNascimento =
        DateTime.parse(map['data_de_nascimento'].toDate().toString());
    this.raca = map['raca'];
  }
}
