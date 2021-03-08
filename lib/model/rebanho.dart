class Rebanho {
  String regiao;
  String finalidade;
  String alimentacaoPrincipal;
  String alimentacaoComplementar;

  Rebanho.novo();

  Rebanho(this.regiao, this.finalidade, this.alimentacaoPrincipal,
      this.alimentacaoComplementar);

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['regiao'] = regiao;
    map['finalidade'] = finalidade;
    map['alimentacao_pricipal'] = alimentacaoPrincipal;
    map['alimentacao_complementar'] = alimentacaoComplementar;

    return map;
  }

  Rebanho.fromDoc(Map<String, dynamic> map) {
    if (map != null) {
      this.regiao = map['regiao'];
      this.finalidade = map['finalidade'];
      this.alimentacaoPrincipal = map['alimentacao_pricipal'];
      this.alimentacaoComplementar = map['alimentacao_complementar'];
    }
  }
}
