import 'package:cloud_firestore/cloud_firestore.dart';

class Doenca {
  String nome;
  String caracteristicas;
  String causas;
  String tratamento;
  String referencia;
  String sintomas;

  Doenca.novo();

  Doenca(
    this.nome,
    this.caracteristicas,
    this.causas,
    this.tratamento,
    this.referencia,
    this.sintomas,
  );

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['nome'] = nome;
    map['caracteristicas'] = caracteristicas;
    map['causas'] = causas;
    map['tratamento'] = tratamento;
    map['referencia'] = referencia;
    map['sintomas'] = sintomas;

    return map;
  }

  Doenca.fromDoc(QueryDocumentSnapshot doc) {
    if (doc != null) {
      Map<String, dynamic> map = doc.data();
      this.nome = map['nome'];
      this.caracteristicas = map['caracteristicas'];
      this.causas = map['causas'];
      this.tratamento = map['tratamento'];
      this.referencia = map['referencia'];
      this.sintomas = map['sintomas'];
    }
  }
}
