import 'package:cloud_firestore/cloud_firestore.dart';

class Manejo {
  String id;
  String atividade;
  String valor;
  DateTime data;

  Manejo.novo();

  Manejo(this.id, this.atividade, this.valor, this.data);

  Manejo.hoje(this.id, this.atividade, this.valor) {
    this.data = DateTime.now();
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['atividade'] = atividade;
    map['valor'] = valor;
    map['data'] = data;
    return map;
  }

  Manejo.fromDoc(QueryDocumentSnapshot doc) {
    if (doc != null) {
      Map<String, dynamic> map = doc.data();
      this.id = doc.id;
      this.atividade = map['atividade'];
      this.valor = map['valor'];
      this.data = map['data'].toDate();
    }
  }
}
