import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<DropdownMenuItem> listaRaca;
  List<DropdownMenuItem> listaSexo;

  @override
  void initState() {
    setState(() {
      listaSexo = ['Fêmea', 'Macho']
          .map((item) => DropdownMenuItem<String>(
                child: Text(item),
                value: item.substring(0, 1),
              ))
          .toList();
    });
    FirebaseFirestore.instance
        .collection('racas')
        .snapshots()
        .listen((colecao) {
      List<DropdownMenuItem> racas = colecao.docs
          .map((doc) => DropdownMenuItem<String>(
                child: Text(doc.id),
                value: doc.id,
              ))
          .toList();
      setState(() {
        listaRaca = racas;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Idade/meses:",
                hintText: 'definier mascara para o campo'),
          ),
          SizedBox(height: 30),
          Container(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  labelText: 'Raça:',
                  contentPadding: EdgeInsets.all(10),
                  counterStyle: TextStyle(color: Colors.red)),
              items: listaRaca,
              onChanged: (value) => print('selecionada :\n' + value),
            ),
          ),
          SizedBox(height: 30),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Peso/Kg:"),
          ),
          SizedBox(height: 30),
          Container(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  labelText: "Sexo:",
                  contentPadding: EdgeInsets.all(10),
                  counterStyle: TextStyle(color: Colors.red)),
              items: listaSexo,
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
