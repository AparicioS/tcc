import 'package:cloud_firestore/cloud_firestore.dart';

class Animal {
  String nBrinco;
  String name;
  String sexo;
  DateTime dataNascimento;
  String raca;

  Animal.novo();

  Animal(this.nBrinco, this.name, this.sexo, this.dataNascimento, this.raca);

  Animal.recenNascido(
    this.nBrinco,
    this.name,
    this.sexo,
    this.raca,
  ) {
    this.dataNascimento = DateTime.now();
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['nome'] = name;
    map['sexo'] = sexo;
    map['data_de_nascimento'] = dataNascimento;
    map['raca'] = raca;

    return map;
  }

  Animal.fromDoc(QueryDocumentSnapshot doc) {
    if (doc != null) {
      Map<String, dynamic> map = doc.data();
      this.nBrinco = doc.id;
      this.name = map['nome'];
      this.sexo = map['sexo'];
      this.dataNascimento = map['data_de_nascimento'].toDate();
      this.raca = map['raca'];
    }
  }
}
