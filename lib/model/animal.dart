import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diagnostico_bovino/util/data_util.dart';

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
    Map<String, dynamic> map = doc.data();
    this.nBrinco = doc.id;
    this.name = map['nome'];
    this.sexo = map['sexo'];
    this.dataNascimento =
        DateTime.parse(map['data_de_nascimento'].toDate().toString());
    this.raca = map['raca'];
    // this.toString();
  }
  @override
  String toString() {
    String dadosAnimal = '';
    dadosAnimal += 'Brinco:' + nBrinco ?? '';
    dadosAnimal += '\n nome:' + name ?? '';
    dadosAnimal += '\n sexo:' + sexo ?? '';
    dadosAnimal += '\n raca:' + raca ?? '';
    dadosAnimal +=
        '\n data_de_nascimento:' + DataUtil.toStringData(dataNascimento);
    return dadosAnimal;
  }
}
