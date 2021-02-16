import 'package:diagnostico_bovino/view/layout.dart';
import 'package:diagnostico_bovino/view/tela_diagnostico_sintomas.dart';
import 'package:flutter/material.dart';

class TelaDiagnosticoDadosAnimal extends StatefulWidget {
  @override
  _TelaDiagnosticoDadosAnimalState createState() =>
      _TelaDiagnosticoDadosAnimalState();
}

class _TelaDiagnosticoDadosAnimalState
    extends State<TelaDiagnosticoDadosAnimal> {
  @override
  Widget build(BuildContext context) {
    int selectedValue = 0;
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

    return ScaffoldLayout(
      body: ListView(
        children: [
          Center(
              child: Text(
            "Dados do Animal",
            style: TextStyle(fontSize: 30),
          )),
          SizedBox(height: 30),
          TextField(
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
                labelText: "Idade:", hintText: 'definier mascara para o campo'),
          ),
          SizedBox(height: 30),
          Container(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  labelText: 'Raça:',
                  contentPadding: EdgeInsets.all(10),
                  counterStyle: TextStyle(color: Colors.red)),
              items: carregarListaDropDow(),
              onChanged: (value) => print('selecionada :\n' + value),
            ),
          ),
          SizedBox(height: 30),
          TextField(
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(labelText: "Peso/Kg:"),
          ),
          SizedBox(height: 30),
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
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => TelaDiagnosticoSintomas()));
          },
          child: Text("Proximo")),
    );
  }
}
