import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diagnostico_bovino/controller/controller_rebanho.dart';
import 'package:diagnostico_bovino/model/rebanho.dart';
import 'package:diagnostico_bovino/model/usuario.dart';
import 'package:diagnostico_bovino/view/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaCadastroRebanho extends StatefulWidget {
  @override
  _TelaCadastroRebanhoState createState() => _TelaCadastroRebanhoState();
}

class _TelaCadastroRebanhoState extends State<TelaCadastroRebanho> {
  List<DropdownMenuItem> listaRegiao;
  List<DropdownMenuItem> listaAlimentacao;
  List<DropdownMenuItem> listaFinalidade;
  Rebanho rebanho;
  String msg;

  @override
  void initState() {
    rebanho = Rebanho.novo();
    FirebaseFirestore.instance
        .collection('Rebanho')
        .doc(Usuario().id)
        .get()
        .then((value) {
      setState(() {
        if (value.id == Usuario().id) {
          rebanho = Rebanho.fromDoc(value.data());
          msg = 'ao alterar registro.';
        } else {
          msg = 'ao incluir registro.';
        }
      });
    });

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
    var form = GlobalKey<FormState>();
    return ScaffoldLayout(
      body: Form(
        key: form,
        child: ListView(
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
            DropdownButtonFormField<String>(
              value: rebanho.regiao,
              onSaved: (data) => rebanho.regiao = data,
              decoration: InputDecoration(
                  labelText: "Região:",
                  contentPadding: EdgeInsets.all(10),
                  counterStyle: TextStyle(color: Colors.red)),
              items: listaRegiao,
              onChanged: (value) => print("selecionado: $value"),
            ),
            SizedBox(height: 30),
            DropdownButtonFormField<String>(
              value: rebanho.alimentacaoPrincipal,
              onSaved: (data) => rebanho.alimentacaoPrincipal = data,
              decoration: InputDecoration(
                  labelText: "Alimentação principal:",
                  contentPadding: EdgeInsets.all(10),
                  counterStyle: TextStyle(color: Colors.red)),
              items: listaAlimentacao,
              onChanged: (value) => print("selecionado: $value"),
            ),
            SizedBox(height: 30),
            DropdownButtonFormField<String>(
              value: rebanho.alimentacaoComplementar,
              onSaved: (data) => rebanho.alimentacaoComplementar = data,
              decoration: InputDecoration(
                  labelText: "Alimentação complementar:",
                  contentPadding: EdgeInsets.all(10),
                  counterStyle: TextStyle(color: Colors.red)),
              items: listaAlimentacao,
              onChanged: (value) => print("selecionado: $value"),
            ),
            SizedBox(height: 30),
            DropdownButtonFormField<String>(
              value: rebanho.finalidade,
              onSaved: (data) => rebanho.finalidade = data,
              decoration: InputDecoration(
                  labelText: "Finalidade:",
                  contentPadding: EdgeInsets.all(10),
                  counterStyle: TextStyle(color: Colors.red)),
              items: listaFinalidade,
              onChanged: (value) => print("selecionado: $value"),
            ),
          ],
        ),
      ),
      floatingActionButton: BotaoRodape(
          child: Text("Salvar"),
          onPressed: () async {
            if (form.currentState.validate()) {
              form.currentState.save();
              var retorno = await ControllerRebanho.cadastrarRebanho(rebanho);
              print(retorno);
              showDialog(
                  context: context,
                  builder: (contx) {
                    return CupertinoAlertDialog(
                      title: Text('Rebanho'),
                      content: Text(retorno + msg),
                      actions: [
                        FlatButton(
                            onPressed: () => Navigator.pop(contx),
                            child: Text('OK'))
                      ],
                    );
                  });
            }
            Navigator.pop(context);
          }),
    );
  }
}
