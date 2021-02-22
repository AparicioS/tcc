class Animal {
  String name;
  String nBrinco;
  String sexo;
  DateTime dataNascimento;
  String raca;

  Animal(this.name, this.nBrinco, this.sexo, this.dataNascimento, this.raca);
  // Animal(String nome, String nBrinco, String sexo, DateTime dataNascimento ,
  //     String raca) {
  //   this.nome = nome;
  //   this.nBrinco = nBrinco;
  //   this.sexo = sexo;
  //   this.dataNascimento = dataNascimento;
  //   this.raca = raca;
  // }
  Animal.semRaca(
    this.name,
    this.nBrinco,
    this.sexo,
    this.dataNascimento,
  ) {
    this.raca = '0';
  }

  Animal.recenNascido(
    this.name,
    this.nBrinco,
    this.sexo,
    this.raca,
  ) {
    this.dataNascimento = DateTime.now();
  }
}
