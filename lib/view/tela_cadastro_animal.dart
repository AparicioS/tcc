import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diagnostico_bovino/controller/controller_rebanho.dart';
import 'package:diagnostico_bovino/model/animal.dart';
import 'package:diagnostico_bovino/util/data_util.dart';
import 'package:diagnostico_bovino/view/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaCadastroAnimal extends StatefulWidget {
  @override
  _TelaCadastroAnimalState createState() => _TelaCadastroAnimalState();
}

class _TelaCadastroAnimalState extends State<TelaCadastroAnimal> {
  List<DropdownMenuItem> listaRaca;
  List<DropdownMenuItem> listaSexo;
  Animal animal;
  String msg;

  @override
  void initState() {
    setState(() {
      msg = 'ao incluir registro ...';
      animal = Animal.novo();
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
                    title: 'Dados do Animal',
                    color: Cor.titulo(),
                    child: Text(
                      "Dados do Animal",
                      style: TextStyle(fontSize: 30),
                    )),
              ),
            ),
            TextFormField(
              onSaved: (valor) => animal.nBrinco = valor,
              validator: (valor) {
                if (valor.isEmpty) {
                  return ' invalido';
                }
                return null;
              },
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Numero do brinco:"),
            ),
            SizedBox(height: 30),
            TextFormField(
              onSaved: (valor) => animal.name = valor,
              decoration: InputDecoration(labelText: "Nome/Identificação:"),
            ),
            SizedBox(height: 30),
            DataUtil.campoData(
              'Data de Nascimento :',
              (valor) => animal.dataNascimento = valor.add(Duration(hours: 3)),
            ),
            DropdownButtonFormField<String>(
              onSaved: (valor) => animal.raca = valor,
              decoration: InputDecoration(
                  labelText: "Raça:",
                  contentPadding: EdgeInsets.all(10),
                  counterStyle: TextStyle(color: Colors.red)),
              items: listaRaca,
              onChanged: (value) => print("selecionado: $value"),
            ),
            DropdownButtonFormField<String>(
              onSaved: (valor) => animal.sexo = valor,
              decoration: InputDecoration(
                labelText: "Sexo:",
                contentPadding: EdgeInsets.all(10),
              ),
              items: listaSexo,
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
            var retorno = await ControllerRebanho.cadastrarAnimal(animal);
            showDialog(
                context: context,
                builder: (ctx) {
                  return CupertinoAlertDialog(
                    title: Text('Animal'),
                    content: Text(retorno + 'ao incluir o registro...'),
                    actions: [
                      FlatButton(
                          onPressed: () {
                            form.currentState.reset();
                            Navigator.pop(ctx);
                          },
                          child: Text('Novo cadstro')),
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(ctx);
                          },
                          child: Text('OK'))
                    ],
                  );
                });
          }
        },
      ),
    );
  }
}
