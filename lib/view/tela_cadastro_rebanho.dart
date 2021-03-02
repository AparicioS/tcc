import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diagnostico_bovino/controller/controller_rebanho.dart';
import 'package:diagnostico_bovino/model/rebanho.dart';
import 'package:diagnostico_bovino/model/usuario.dart';
import 'package:diagnostico_bovino/view/layout.dart';
import 'package:flutter/material.dart';

class TelaCadastroRebanho extends StatefulWidget {
  @override
  _TelaCadastroRebanhoState createState() => _TelaCadastroRebanhoState();
}

class _TelaCadastroRebanhoState extends State<TelaCadastroRebanho> {
  List<DropdownMenuItem> listaRegiao;
  List<DropdownMenuItem> listaAlimentacao;
  List<DropdownMenuItem> listaFinalidade;

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('regiao')
        .snapshots()
        .listen((colecao) {
      List<DropdownMenuItem> lista = colecao.docs
          .map((doc) => DropdownMenuItem<String>(
                child: Text(doc.id),
                value: doc.id,
              ))
          .toList();
      setState(() {
        listaRegiao = lista;
      });
    });
    FirebaseFirestore.instance
        .collection('alimentacao')
        .snapshots()
        .listen((colecao) {
      List<DropdownMenuItem> lista = colecao.docs
          .map((doc) => DropdownMenuItem<String>(
                child: Text(doc.id),
                value: doc.id,
              ))
          .toList();
      setState(() {
        listaAlimentacao = lista;
      });
    });
    FirebaseFirestore.instance
        .collection('finalidade')
        .snapshots()
        .listen((colecao) {
      List<DropdownMenuItem> lista = colecao.docs
          .map((doc) => DropdownMenuItem<String>(
                child: Text(doc.id),
                value: doc.id,
              ))
          .toList();
      setState(() {
        listaFinalidade = lista;
      });
    });

    super.initState();
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
                  title: 'Dados do Rebanho',
                  color: Cor.titulo(),
                  child: Text(
                    'Dados do Rebanho',
                    style: TextStyle(fontSize: 30),
                  )),
            ),
          ),
          Container(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  labelText: "Região:",
                  contentPadding: EdgeInsets.all(10),
                  counterStyle: TextStyle(color: Colors.red)),
              items: listaRegiao,
              onChanged: (value) => print("selecionado: $value"),
            ),
          ),
          SizedBox(height: 30),
          Container(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  labelText: "Alimentação principal:",
                  contentPadding: EdgeInsets.all(10),
                  counterStyle: TextStyle(color: Colors.red)),
              items: listaAlimentacao,
              onChanged: (value) => print("selecionado: $value"),
            ),
          ),
          SizedBox(height: 30),
          Container(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  labelText: "Alimentação complementar:",
                  contentPadding: EdgeInsets.all(10),
                  counterStyle: TextStyle(color: Colors.red)),
              items: listaAlimentacao,
              onChanged: (value) => print("selecionado: $value"),
            ),
          ),
          SizedBox(height: 30),
          Container(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  labelText: "Finalidade:",
                  contentPadding: EdgeInsets.all(10),
                  counterStyle: TextStyle(color: Colors.red)),
              items: listaFinalidade,
              onChanged: (value) => print("selecionado: $value"),
            ),
          ),
        ],
      ),
      floatingActionButton: BotaoRodape(
          child: Text("Salvar"),
          onPressed: () {
            Rebanho rebanho = Rebanho(Usuario().id, 'Sul', 'cria', 'pasto', '');
            ControllerRebanho.cadastrarRebanho(rebanho);
            Navigator.pop(context);
          }),
    );
  }
}
