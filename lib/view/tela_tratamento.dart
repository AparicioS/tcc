import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diagnostico_bovino/controller/controller_rebanho.dart';
import 'package:diagnostico_bovino/model/animal.dart';
import 'package:diagnostico_bovino/model/tratamento.dart';
import 'package:diagnostico_bovino/util/data_util.dart';
import 'package:diagnostico_bovino/view/layout.dart';
import 'package:diagnostico_bovino/view/painel_dados_animal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

class TelaTratamento extends StatefulWidget {
  @override
  _TelaTratamentoState createState() => _TelaTratamentoState();
}

class _TelaTratamentoState extends State<TelaTratamento> {
  List<DropdownMenuItem> listaViaAdministracao;
  Animal animal;
  Tratamento tratamento;

  @override
  void initState() {
    tratamento = Tratamento.novo();
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
    var form = GlobalKey<FormState>();
    return ScaffoldLayout(
        body: Form(
          key: form,
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
              // campo data de aplica
              DataUtil.campoData(
                  'Data de Aplicação:',
                  (valor) =>
                      tratamento.dataAplicacao = valor.add(Duration(hours: 3))),
              SizedBox(height: 30),
              // campo medicamento
              TextFormField(
                onSaved: (valor) => tratamento.medicamento = valor,
                validator: (valor) {
                  if (valor.isEmpty) {
                    return 'campo obrigatorio';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Medicamento:'),
              ),
              SizedBox(height: 30),
              // campo via de aplicacao
              DropdownButtonFormField<String>(
                onSaved: (valor) => tratamento.viaAplicacao = valor,
                decoration: InputDecoration(
                    labelText: "Via de Aplicação:",
                    contentPadding: EdgeInsets.all(10),
                    counterStyle: TextStyle(color: Colors.red)),
                items: listaViaAdministracao,
                onChanged: (value) => print("selecionado: $value"),
              ),
              SizedBox(height: 30),
              // campo dosagem
              TextFormField(
                onSaved: (valor) => tratamento.dose = valor,
                validator: (valor) {
                  if (valor.isEmpty) {
                    return 'campo obrigatorio';
                  }
                  return null;
                },
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
              var retorno = await ControllerRebanho.cadastrarTratamento(
                  animal, tratamento);
              print('retorno');
              print(retorno);
              Navigator.pop(context);
            }
          },
        ));
  }
}
