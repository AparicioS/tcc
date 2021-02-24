import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diagnostico_bovino/model/animal.dart';
import 'package:diagnostico_bovino/util/data_util.dart';
import 'package:diagnostico_bovino/view/layout.dart';
import 'package:flutter/material.dart';

class TelaTratamento extends StatefulWidget {
  @override
  _TelaTratamentoState createState() => _TelaTratamentoState();
}

class _TelaTratamentoState extends State<TelaTratamento> {
  List<DropdownMenuItem> listaViaAdministracao;
  Container dadosDoAnimal;
  Animal animal;

  @override
  void initState() {
    print('initState');
    FirebaseFirestore.instance
        .collection('aplicacao')
        .snapshots()
        .listen((colecao) {
      List<DropdownMenuItem> lista = colecao.docs
          .map((doc) => DropdownMenuItem<String>(
                child: Text(doc.id),
                value: doc.id,
              ))
          .toList();
      setState(() {
        listaViaAdministracao = lista;
      });
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      animal = ModalRoute.of(context).settings.arguments;
      dadosDoAnimal = Container(
        child: Column(
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
        ),
      );
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    animal = ModalRoute.of(context).settings.arguments;
    print('buid');
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
            dadosDoAnimal,
            SizedBox(height: 30),
            DataUtil.campoData('Data de Aplicação:'),
            SizedBox(height: 30),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Medicamento:'),
            ),
            SizedBox(height: 30),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  labelText: "Via de Aplicação:",
                  contentPadding: EdgeInsets.all(10),
                  counterStyle: TextStyle(color: Colors.red)),
              items: listaViaAdministracao,
              onChanged: (value) => print("selecionado: $value"),
            ),
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
}
