import 'package:diagnostico_bovino/model/animal.dart';
import 'package:diagnostico_bovino/view/painel_dados_animal.dart';
import 'package:flutter/material.dart';
import 'package:diagnostico_bovino/view/layout.dart';

class TelaProntuario extends StatelessWidget {
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
                    title: 'Prontuario Animal',
                    color: Cor.titulo(),
                    child: Text(
                      'Prontuário Animal',
                      style: TextStyle(fontSize: 30),
                    )),
              ),
            ),
            PainelDadosAnimal(animal: animal),
            SizedBox(height: 30),
            pesagensRealizadas(animal),
            SizedBox(height: 30),
            tratamentosAplicados(animal)
          ],
        ),
        floatingActionButton: BotaoRodape(
            child: Text("Fechar"), onPressed: () => Navigator.pop(context)));
  }

  tratamentosAplicados(animal) {
    return Column(
      children: [
        Container(
          child: Title(
              color: Cor.titulo(),
              child: Text(
                'Historico de Tratamentos',
                style: TextStyle(fontSize: 25),
              )),
        ),
        Container(
          child: DataTable(columnSpacing: 50, columns: [
            DataColumn(
                label: Text(
              'Data',
              style: TextStyle(fontSize: 15),
            )),
            DataColumn(
                label: Text(
              'Finalidade',
              style: TextStyle(fontSize: 15),
            )),
            DataColumn(
                label: Text(
              'Medicamento',
              style: TextStyle(fontSize: 15),
            )),
          ], rows: [
            DataRow(cells: [
              DataCell(Text('10/12/2020')),
              DataCell(Text('vacina')),
              DataCell(Text('Azatioprina'))
            ]),
          ]),
        ),
      ],
    );
  }

  pesagensRealizadas(animal) {
    return Column(
      children: [
        Container(
          child: Title(
              color: Cor.titulo(),
              child: Text(
                'Historico de Peso',
                style: TextStyle(fontSize: 25),
              )),
        ),
        Container(
          child: DataTable(columnSpacing: 180, columns: [
            DataColumn(
                label: Text(
              'data:',
              style: TextStyle(fontSize: 15),
            )),
            DataColumn(
                label: Text(
              'peso/Kg:',
              style: TextStyle(fontSize: 15),
            )),
          ], rows: [
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
