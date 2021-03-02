import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diagnostico_bovino/controller/controller_rebanho.dart';
import 'package:diagnostico_bovino/model/animal.dart';
import 'package:diagnostico_bovino/util/data_util.dart';
import 'package:diagnostico_bovino/view/layout.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class TelaCadastroAnimal extends StatefulWidget {
  @override
  _TelaCadastroAnimalState createState() => _TelaCadastroAnimalState();
}

class _TelaCadastroAnimalState extends State<TelaCadastroAnimal> {
  List<DropdownMenuItem> listaRaca;
  List<DropdownMenuItem> listaSexo;
  String uid;

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
  void didChangeDependencies() {
    print('didChangeDependencies');
    context.getSignedInUser().when(
          (user) => uid = user.uid,
          empty: () => Text('Not signed in'),
          initializing: () => Text('Loading'),
        );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return ScaffoldLayout(
      body: ListView(
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
            validator: (data) {
              if (data.isEmpty) {
                return ' invalido';
              }
              return null;
            },
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Numero do brinco:"),
          ),
          SizedBox(height: 30),
          TextField(
            obscureText: true,
            decoration: InputDecoration(labelText: "Nome/Identificação:"),
          ),
          SizedBox(height: 30),
          DataUtil.campoData('Data de Nascimento :'),
          Container(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  labelText: "Raça:",
                  contentPadding: EdgeInsets.all(10),
                  counterStyle: TextStyle(color: Colors.red)),
              items: listaRaca,
              onChanged: (value) => print(" a raça selecionada foi $value"),
            ),
          ),
          Container(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Sexo:",
                contentPadding: EdgeInsets.all(10),
              ),
              items: listaSexo,
              onChanged: (value) => print("sexo selecionado: $value"),
            ),
          ),
        ],
      ),
      floatingActionButton: BotaoRodape(
        child: Text("Salvar"),
        onPressed: () {
          Animal animal = Animal.recenNascido("touro", "23", "macho", "Giu");
          ControllerRebanho.cadastrarAnimal(animal);
          Navigator.pop(context);
        },
      ),
    );
  }
}
