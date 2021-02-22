import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:diagnostico_bovino/model/animal.dart';
import 'package:diagnostico_bovino/util/data_util.dart';
import 'package:diagnostico_bovino/view/layout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TelaTratamento extends StatefulWidget {
  @override
  _TelaTratamentoState createState() => _TelaTratamentoState();
}

class _TelaTratamentoState extends State<TelaTratamento> {
  @override
  Widget build(BuildContext context) {
    Animal animal = ModalRoute.of(context).settings.arguments;
    return ScaffoldLayout(
        body: ListView(
          children: [
            SizedBox(
              height: 50,
              child: Center(
                child: Title(
                    title: 'Aplicar Tratamento',
                    color: Cor.titulo(),
                    child: Text(
                      "Aplicar Tratamento",
                      style: TextStyle(fontSize: 30),
                    )),
              ),
            ),
            containerDadosDoAnimal(animal),
            SizedBox(height: 30),
            _dataDeAplicacao,
            SizedBox(height: 30),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Medicamento:'),
            ),
            SizedBox(height: 30),
            _viaDeAplicacao,
            SizedBox(height: 30),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Dosagem:'),
            ),
          ],
        ),
        floatingActionButton: BotaoRodape(
            child: Text("Salvar"), onPressed: () => Navigator.pop(context)));
  }

  final _dataDeAplicacao = DateTimeField(
      decoration: InputDecoration(
        labelText: 'Data de Aplicação:',
      ),
      format: DateFormat('dd/MM/yyyy'),
      onSaved: (data) => print(data),
      onChanged: (data) {
        print(DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br').format(data));
      },
      initialValue: DateTime.now(),
      keyboardType: TextInputType.datetime,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            locale: Locale('pt'),
            context: context,
            initialDate: currentValue ?? DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 730)),
            lastDate: DateTime.now());
      });
}

final _vias = ['Via Oral', 'Subcutânea', 'Intravenosa', 'Intramuscular'];
final _viaDeAplicacao = DropdownButtonFormField<String>(
  decoration: InputDecoration(
      labelText: "Via de Aplicação:",
      contentPadding: EdgeInsets.all(10),
      counterStyle: TextStyle(color: Colors.red)),
  items: _vias.map((String categoria) {
    debugPrint(categoria);
    return DropdownMenuItem<String>(
      child: Text(categoria),
      value: categoria,
    );
  }).toList(),
  onChanged: (value) => print("selecionado: $value"),
);

containerDadosDoAnimal(animal) {
  return Column(
    children: [
      Container(
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Title(
              color: Cor.titulo(),
              child: Text(
                'Dados do Animal',
                style: TextStyle(fontSize: 20),
              )),
        ),
      ),
      Container(
          child: Table(children: [
        TableRow(children: [
          Text('Numero do brinco:'),
          Text(animal.nBrinco),
        ]),
        TableRow(children: [
          Text('Nome/identificação:'),
          Text(animal.name),
        ]),
        TableRow(children: [
          Text('Idade:'),
          Text(DataUtil.idadebyDataNascimento(animal.dataNascimento)),
        ]),
        TableRow(children: [
          Text('Sexo:'),
          Text(animal.sexo),
        ]),
      ])),
    ],
  );
}
