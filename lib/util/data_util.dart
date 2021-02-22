class Interval {
  Interval({DateTime data})
      : super(
        // dias : DateTime.now().difference(data).inDays,
        // ano :dias ~/ 365,
        // mes = dias % 365 ~/ 30,
        // dia = dias % 365 % 30,
        );
  var dia;
  var mes;
  var ano;
  int dias;

  // const Inteval({data}):super(
  // int dias = DateTime.now().difference(data).inDays;
  // this.ano = dias ~/ 365;
  // this.mes = dias % 365 ~/ 30;
  // this.dia = dias % 365 % 30;
  // )

  @override
  String toString() {
    String anos = this.ano > 1 ? ' anos' : ' ano';
    anos = this.ano > 0 ? anos : '';
    String meses = this.mes > 1 ? ' meses' : ' mês';
    meses = this.mes > 0 ? meses : '';
    String dias = this.dia > 1 ? ' dias' : ' dia';
    dias = this.dia > 0 ? dias : '';

    String idade = "$ano $anos $mes $meses $dia $dias ";

    return idade;
  }
}

class DataUtil {
  static String idadebyDataNascimento(DateTime data) {
    DateTime hoje = DateTime.now();
    int ano = hoje.year - data.year;
    int mes = hoje.month - data.month;
    int dia = hoje.day - data.day;
    if (hoje.month < data.month ||
        (hoje.month == data.month && hoje.day < data.day)) {
      mes += 12;
      ano--;
    }
    if (hoje.day < data.day) {
      mes--;
      dia = 30 - (data.day - hoje.day);
    }

    String anos = ano > 1 ? 'anos ' : 'ano ';
    anos = ano > 0 ? (ano.toString() + anos) : '';
    String meses = mes > 1 ? 'meses ' : 'mês ';
    meses = mes > 0 ? (mes.toString() + meses) : '';
    String dias = dia > 1 ? 'dias ' : 'dia ';
    dias = dia > 0 ? (dia.toString() + dias) : '';
    String idade = '';
    idade = dias.isNotEmpty ? dias + idade : idade;
    idade = meses.isNotEmpty
        ? meses + (idade.isNotEmpty ? 'e ' + idade : '')
        : idade;
    idade = anos.isNotEmpty
        ? anos +
            (idade.isNotEmpty && !idade.contains(' e ') ? 'e ' + idade : idade)
        : idade;
    idade = idade.isEmpty ? '1dia' : idade;

    return idade;
  }
}
