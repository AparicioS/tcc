import 'package:cloud_firestore/cloud_firestore.dart';

class Rebanho {
  String proprietario;
  String regiao;
  String finalidade;
  String alimentacaoPrincipal;
  String alimentacaoComplementar;

  Rebanho(this.proprietario, this.regiao, this.finalidade,
      this.alimentacaoPrincipal, this.alimentacaoComplementar);

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['proprietario'] = proprietario;
    map['regiao'] = regiao;
    map['finalidade'] = finalidade;
    map['alimentacao_pricipal'] = alimentacaoPrincipal;
    map['alimentacao_complementar'] = alimentacaoComplementar;

    return map;
  }

  Rebanho.fromDoc(QueryDocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data();
    this.proprietario = map['proprietario'];
    this.regiao = map['regiao'];
    this.finalidade = map['finalidade'];
    this.alimentacaoPrincipal = map['alimentacao_pricipal'];
    this.alimentacaoComplementar = map['alimentacao_complementar'];
  }
}
