import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diagnostico_bovino/model/animal.dart';
import 'package:diagnostico_bovino/model/manejo.dart';
import 'package:diagnostico_bovino/model/tratamento.dart';
import 'package:diagnostico_bovino/model/usuario.dart';
import 'package:diagnostico_bovino/util/data_util.dart';
import 'package:diagnostico_bovino/view/painel_dados_animal.dart';
import 'package:flutter/material.dart';
import 'package:diagnostico_bovino/view/layout.dart';

class TelaProntuario extends StatefulWidget {
  @override
  _TelaProntuarioState createState() => _TelaProntuarioState();
}

class _TelaProntuarioState extends State<TelaProntuario> {
  Animal animal;
  @override
  void didChangeDependencies() {
    animal = ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
            manejo(),
            SizedBox(height: 30),
            tratamentos()
          ],
        ),
        floatingActionButton: BotaoRodape(
            child: Text("Fechar"), onPressed: () => Navigator.pop(context)));
  }

  tratamentos() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Rebanho')
            .doc(Usuario().id)
            .collection('Animais')
            .doc(animal.nBrinco)
            .collection('tratamento')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapsho) {
          switch (snapsho.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              if (snapsho.data.docs.length == 0) {
                print('lista vazia');
              }
              List<Tratamento> lista = snapsho.data.docs
                  .map((doc) => Tratamento.fromDoc(doc))
                  .toList();
              return tratamentosAplicados(lista);
          }
        });
  }

  manejo() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Rebanho')
            .doc(Usuario().id)
            .collection('Animais')
            .doc(animal.nBrinco)
            .collection('manejo')
            .where('ativida' 'pesagem')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapsho) {
          switch (snapsho.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              if (snapsho.data.docs.length == 0) {
                print('lista vazia');
              }
              List<Manejo> lista =
                  snapsho.data.docs.map((doc) => Manejo.fromDoc(doc)).toList();
              return pesagensRealizadas(lista);
          }
        });
  }

  tratamentosAplicados(tratamentos) {
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
          child: DataTable(
            columnSpacing: 50,
            columns: [
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
            ],
            rows: List<DataRow>.generate(
                tratamentos.length,
                (index) => DataRow(cells: [
                      DataCell(Text(DataUtil.toStringData(
                          tratamentos[index].dataAplicacao))),
                      DataCell(Text(tratamentos[index].finalidade.toString())),
                      DataCell(Text(tratamentos[index].medicamento.toString()))
                    ])),
          ),
        ),
      ],
    );
  }

  pesagensRealizadas(pesos) {
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
          child: DataTable(
            columnSpacing: 180,
            columns: [
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
            ],
            rows: List<DataRow>.generate(
                pesos.length,
                (index) => DataRow(cells: [
                      DataCell(Text(DataUtil.toStringData(pesos[index].data))),
                      DataCell(Text(pesos[index].valor.toString())),
                    ])),
          ),
        ),
      ],
    );
  }
}
