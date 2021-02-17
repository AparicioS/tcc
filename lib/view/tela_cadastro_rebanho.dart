import 'package:diagnostico_bovino/view/layout.dart';
import 'package:diagnostico_bovino/view/tela_pricipal.dart';
import 'package:flutter/material.dart';

class TelaCadastroRebanho extends StatefulWidget {
  @override
  _TelaCadastroRebanhoState createState() => _TelaCadastroRebanhoState();
}

class _TelaCadastroRebanhoState extends State<TelaCadastroRebanho> {
  final _regiao = ['Norte', 'Sul'];
  final _alimetacao = ['Pastagem', 'Silo'];
  final _finalidade = ['Cria', 'Recria', 'Engorda'];
  carregarListaDropDow(List<String> lista) {
    return lista.map((String item) {
      debugPrint(item);
      return DropdownMenuItem<String>(
        child: Text(item),
        value: item,
      );
    }).toList();
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
              items: carregarListaDropDow(_regiao),
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
              items: carregarListaDropDow(_alimetacao),
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
              items: carregarListaDropDow(_alimetacao),
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
              items: carregarListaDropDow(_finalidade),
              onChanged: (value) => print("selecionado: $value"),
            ),
          ),
        ],
      ),
      floatingActionButton: BotaoRodape(
        child: Text("Salvar"),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => TelaPricipal()));
        },
      ),
    );
  }
}
