// import 'package:cloud_firestore/cloud_firestore.dart';

class Rebanho {
  String regiao;
  String finalidade;
  String alimentacaoPrincipal;
  String alimentacaoComplementar;

  Rebanho(this.regiao, this.finalidade, this.alimentacaoPrincipal,
      this.alimentacaoComplementar);

  Rebanho.novo();

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['regiao'] = regiao;
    map['finalidade'] = finalidade;
    map['alimentacao_pricipal'] = alimentacaoPrincipal;
    map['alimentacao_complementar'] = alimentacaoComplementar;

    return map;
  }

  Rebanho.fromDoc(map) {
    this.regiao = map['regiao'];
    this.finalidade = map['finalidade'];
    this.alimentacaoPrincipal = map['alimentacao_pricipal'];
    this.alimentacaoComplementar = map['alimentacao_complementar'];
  }

  @override
  String toString() {
    return 'regiao:' + regiao ??
        '' + '\n finalidade:' + finalidade ??
        '' + '\n alimentacao_pricipal:' + alimentacaoPrincipal ??
        '' + '\n alimentacao_complementar:' + alimentacaoComplementar ??
        '';
  }
}
