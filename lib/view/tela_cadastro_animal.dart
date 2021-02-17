import 'package:diagnostico_bovino/view/layout.dart';
import 'package:diagnostico_bovino/view/tela_pricipal.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class TelaCadastroAnimal extends StatefulWidget {
  @override
  _TelaCadastroAnimalState createState() => _TelaCadastroAnimalState();
}

class _TelaCadastroAnimalState extends State<TelaCadastroAnimal> {
  carregarListaDropDow() {
    final _categorias = [
      'Alberes',
      'Angus',
      'Beefalo',
      'Guzerá',
      'Nelore',
      'Senepol'
    ];
    return _categorias.map((String categoria) {
      debugPrint(categoria);
      return DropdownMenuItem<String>(
        child: Text(categoria),
        value: categoria,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldLayout(
      body: ListView(
        children: [
          SizedBox(
            height: 60,
            child: Center(
              child: Title(
                  title: 'Dados do Animal',
                  color: Cor.titulo(),
                  child: Text(
                    "Dados do Animal",
                    style: TextStyle(fontSize: 30),
                  )),
            ),
          ),
          TextField(
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(labelText: "Numero do brinco:"),
          ),
          SizedBox(height: 30),
          TextField(
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(labelText: "Nome/Identificação:"),
          ),
          SizedBox(height: 30),
          DateTimeField(
              decoration: InputDecoration(
                labelText: 'Data de Nascimento :',
              ),
              format: DateFormat('dd/MM/yyyy'),
              onSaved: (data) => print(data),
              onChanged: (data) => print(
                  DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br')
                      .format(DateTime.now())),
              initialValue: DateTime.now(),
              keyboardType: TextInputType.datetime,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    locale: Locale('pt'),
                    context: context,
                    initialDate: currentValue ?? DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 365)),
                    lastDate: DateTime.now());
              }),
          Container(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  labelText: "Raça:",
                  contentPadding: EdgeInsets.all(10),
                  counterStyle: TextStyle(color: Colors.red)),
              items: carregarListaDropDow(),
              onChanged: (value) => print(" a raça selecionada foi $value"),
            ),
          ),
          Container(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  labelText: "Sexo:",
                  contentPadding: EdgeInsets.all(10),
                  counterStyle: TextStyle(color: Colors.red)),
              items: [
                DropdownMenuItem<String>(
                  child: Text('Macho'),
                  value: 'macho',
                ),
                DropdownMenuItem<String>(
                  child: Text('Fêmea'),
                  value: 'femea',
                ),
              ],
              onChanged: (value) => print("sexo selecionado: $value"),
            ),
          ),
        ],
      ),
      floatingActionButton: BotaoRodape(
        child: Text("Salvar"),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => TelaPricipal()));
        },
      ),
    );
  }
}
