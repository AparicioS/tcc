import 'package:cloud_firestore/cloud_firestore.dart';

class Tratamento {
  String id;
  String finalidade;
  String medicamento;
  String viaAplicacao;
  String dose;
  DateTime dataAplicacao;

  Tratamento.novo();

  Tratamento(this.id, this.finalidade, this.medicamento, this.viaAplicacao,
      this.dose, this.dataAplicacao);

  Tratamento.hoje(this.id, this.finalidade, this.medicamento, this.viaAplicacao,
      this.dose) {
    this.dataAplicacao = DateTime.now();
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['finalidade'] = finalidade;
    map['medicamento'] = medicamento;
    map['via_aplicacao'] = viaAplicacao;
    map['dose'] = dose;
    map['data_aplicacao'] = dataAplicacao;
    return map;
  }

  Tratamento.fromDoc(QueryDocumentSnapshot doc) {
    if (doc != null) {
      Map<String, dynamic> map = doc.data();
      this.id = doc.id;
      this.finalidade = map['finalidade'];
      this.medicamento = map['medicamento'];
      this.viaAplicacao = map['via_aplicacao'];
      this.dose = map['dose'];
      this.dataAplicacao = map['data_aplicacao'].toDate();
    }
  }
}
