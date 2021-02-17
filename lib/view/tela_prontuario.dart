import 'package:diagnostico_bovino/view/tela_pricipal.dart';
import 'package:flutter/material.dart';
import 'package:diagnostico_bovino/view/layout.dart';

class TelaProntuario extends StatelessWidget {
  Animal animal;
  @override
  Widget build(BuildContext context) {
    animal = ModalRoute.of(context).settings.arguments;
    return ScaffoldLayout(
      body: ListView(
        children: [
          SizedBox(height: 30),
          containerDadosDoAnimal(),
          SizedBox(height: 30),
          pesagensRealizadas(),
          SizedBox(height: 30),
          tratamentosAplicados()
        ],
      ),
      floatingActionButton: BotaoRodape(
        child: Text("Fechar"),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => TelaPricipal()));
        },
      ),
    );
  }

  containerDadosDoAnimal() {
    return Column(
      children: [
        Container(
          child: Title(
              color: Cor.titulo(),
              child: Text(
                'Dados do Animal',
                style: TextStyle(fontSize: 30),
              )),
        ),
        Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.topCenter,
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
                Text(animal.dataNascimento),
              ]),
              TableRow(children: [
                Text('Sexo:'),
                Text(animal.sexo),
              ]),
            ])),
      ],
    );
  }

  tratamentosAplicados() {
    return Column(
      children: [
        Container(
          child: Title(
              color: Cor.titulo(),
              child: Text(
                'Historico de Tratamentos',
                style: TextStyle(fontSize: 30),
              )),
        ),
        Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.topCenter,
            child: Table(children: [
              TableRow(children: [
                Text('Data:', style: TextStyle(fontSize: 20)),
                Text('Tratamento:', style: TextStyle(fontSize: 20)),
                Text('????:', style: TextStyle(fontSize: 20)),
              ]),
            ])),
      ],
    );
  }

  pesagensRealizadas() {
    return Column(
      children: [
        Container(
          child: Title(
              color: Cor.titulo(),
              child: Text(
                'Historico de Peso',
                style: TextStyle(fontSize: 30),
              )),
        ),
        Container(
          child: DataTable(
              columnSpacing: 200,
              dataTextStyle: TextStyle(color: Cor.titulo(), fontSize: 20),
              columns: [
                DataColumn(
                    label: Text(
                  'data:',
                )),
                DataColumn(
                    label: Text(
                  'peso/Kg:',
                )),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('10/12/2020')),
                  DataCell(Text('453,300'))
                ]),
              ]),
        ),
      ],
    );
  }
}
