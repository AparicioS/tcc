import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diagnostico_bovino/model/animal.dart';
import 'package:diagnostico_bovino/util/data_util.dart';
import 'package:diagnostico_bovino/view/layout.dart';
import 'package:diagnostico_bovino/view/painel_dados_animal.dart';
import 'package:flutter/material.dart';

class TelaTratamento extends StatefulWidget {
  @override
  _TelaTratamentoState createState() => _TelaTratamentoState();
}

class _TelaTratamentoState extends State<TelaTratamento> {
  List<DropdownMenuItem> listaViaAdministracao;
  Animal animal;

  @override
  void initState() {
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
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    animal = ModalRoute.of(context).settings.arguments;
    var form = GlobalKey<FormState>();
    return ScaffoldLayout(
        body: Form(
          child: ListView(
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
              PainelDadosAnimal(animal: animal),
              SizedBox(height: 30),
              DataUtil.campoData(
                  'Data de Aplicação:',
                  (valor) =>
                      animal.dataNascimento = valor.add(Duration(hours: 3))),
              SizedBox(height: 30),
              TextFormField(
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
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Dosagem:'),
              ),
            ],
          ),
        ),
        floatingActionButton: BotaoRodape(
          child: Text("Salvar"),
          onPressed: () async {
            if (form.currentState.validate()) {
              form.currentState.save();
              Navigator.pop(context);
            }
          },
        ));
  }
}
