import 'package:diagnostico_bovino/view/layout.dart';
import 'package:flutter/material.dart';

class TelaDiagnostico extends StatefulWidget {
  @override
  _TelaDiagnosticoState createState() => _TelaDiagnosticoState();
}

class _TelaDiagnosticoState extends State<TelaDiagnostico> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldLayout(
        body: ListView(
          children: [
            SizedBox(height: 30),
            Center(
                child: Text(
              "Diagnostico",
              style: TextStyle(fontSize: 30),
            )),
            SizedBox(height: 30),
            Container(
              child: DataTable(columnSpacing: 180, columns: [
                DataColumn(label: Text('Resultados')),
              ], rows: [
                DataRow(
                    cells: [DataCell(Text('lista de possiveis resultados '))]),
              ]),
            ),
            SizedBox(height: 30),
            Container(
              child: DataTable(columnSpacing: 180, columns: [
                DataColumn(label: Text('Diagnostico')),
              ], rows: [
                DataRow(cells: [
                  DataCell(Text(
                      'Sinais clinicos e informações consideradas no diagnostico apresentado'))
                ]),
              ]),
            ),
            SizedBox(height: 30),
            Container(
              child: DataTable(columnSpacing: 180, columns: [
                DataColumn(label: Text('Recomendação')),
              ], rows: [
                DataRow(cells: [
                  DataCell(Text(
                      'Recomendações de consulta tratamentes e procedimentos'))
                ]),
              ]),
            ),
          ],
        ),
        floatingActionButton: BotaoRodape(
          child: Text("Proximo"),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => TelaDiagnostico()));
          },
        ));
  }
}
