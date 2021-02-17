import 'package:diagnostico_bovino/view/layout.dart';
import 'package:diagnostico_bovino/view/tela_cadastro_animal.dart';
import 'package:diagnostico_bovino/view/tela_cadastro_rebanho.dart';
import 'package:diagnostico_bovino/view/tela_prontuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class TelaPricipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizewidth = MediaQuery.of(context).size.width;
    final sizeheight = (MediaQuery.of(context).size.height -
        (kToolbarHeight + MediaQuery.of(context).padding.top));
    final double _imagemWidthSize = sizewidth * 0.5;
    final double _imagemHeightSize = sizeheight * 0.25;
    final double _fonteSize = 25;
    return ScaffoldLayout(
      body: Column(
        children: [
          AcaoTopo(
              icone: Icons.logout,
              texto: 'sair',
              onPressed: () => context.signOut()),
          Container(
            child: Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => TelaCadastroAnimal()));
                      },
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'imagens/animal.png',
                                  width: _imagemWidthSize,
                                  height: _imagemHeightSize,
                                ),
                                Text('Animal',
                                    style: TextStyle(fontSize: _fonteSize))
                              ]))),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => TelaCadastroRebanho()));
                      },
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'imagens/rebanho.png',
                                  width: _imagemWidthSize,
                                  height: _imagemHeightSize,
                                ),
                                Text('Rebanho',
                                    style: TextStyle(fontSize: _fonteSize))
                              ]))),
                  FlatButton(
                      onPressed: () => showSearch(
                          context: context,
                          delegate: CustomSearchDelegate(
                              hintText: 'numero do brinco')),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'imagens/prontuario.png',
                                  width: _imagemWidthSize,
                                  height: _imagemHeightSize,
                                ),
                                Text('Prontuario',
                                    style: TextStyle(fontSize: _fonteSize))
                              ]))),
                  FlatButton(
                      onPressed: () {
                        // showSearch(
                        //     context: context, delegate: CustomSearchDelegate());
                      },
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'imagens/manejo.png',
                                  width: _imagemWidthSize,
                                  height: _imagemHeightSize,
                                ),
                                Text('Manejo',
                                    style: TextStyle(fontSize: _fonteSize))
                              ]))),
                  FlatButton(
                      onPressed: () {
                        print("Diagnostico...+++");
                      },
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'imagens/diagnostico.png',
                                  width: _imagemWidthSize,
                                  height: _imagemHeightSize,
                                ),
                                Text('Diagnostico',
                                    style: TextStyle(fontSize: _fonteSize))
                              ]))),
                  FlatButton(
                      onPressed: () {
                        print("Tratamento...+++");
                      },
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'imagens/tratamento.png',
                                  width: _imagemWidthSize,
                                  height: _imagemHeightSize,
                                ),
                                Text('Tratamento',
                                    style: TextStyle(fontSize: _fonteSize))
                              ]))),
                ],
              ),
            ),
          ),
        ],
      ),
      // ),
      // ],
    );
  }
}

class Animal {
  const Animal(
      this.name, this.nBrinco, this.sexo, this.dataNascimento, this.raca);

  final String name;
  final String nBrinco;
  final String sexo;
  final String dataNascimento;
  final String raca;
}

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({
    String hintText,
  }) : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  static const List<Animal> rebanho = [
    Animal('boi 1', '123456789123', 'macho', '10/10/2020', 'raça'),
    Animal('boi 2', '165216511651', 'femea', '10/10/2020', 'raça'),
    Animal('boi 3', '166116511651', 'macho', '10/10/2020', 'raça'),
    Animal('boi 4', '166116511651', 'femea', '10/10/2020', 'raça'),
    Animal('boi 5', '175116511651', 'macho', '10/10/2020', 'raça'),
    Animal('boi 6', '175116511651', 'femea', '10/10/2020', 'raça'),
    Animal('boi 7', '265116511651', 'macho', '10/10/2020', 'raça'),
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => this.query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => this.close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    abrirProntuario(animal) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => TelaProntuario(),
          settings: RouteSettings(arguments: animal)));
    }

    return ListView.builder(
      itemCount: filtrarRebanhoByQuery().length,
      itemBuilder: (context, index) {
        Animal animal = filtrarRebanhoByQuery()[index];
        return ListTile(
          leading: SizedBox(width: 150, child: Text(animal.nBrinco)),
          title: Text(animal.name),
          subtitle: Text(animal.dataNascimento),
          trailing: Text(animal.sexo),
          onTap: () {
            abrirProntuario(animal);
          },
        );
      },
    );
  }

  @SemanticsHintOverrides()
  Widget buildSuggestions(BuildContext context) {
    abrirProntuario(animal) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => TelaProntuario(),
          settings: RouteSettings(arguments: animal)));
    }

    return ListView.builder(
      itemCount: filtrarRebanhoByQuery().length,
      itemBuilder: (context, index) {
        Animal animal = filtrarRebanhoByQuery()[index];
        return ListTile(
          title: Text(animal.nBrinco),
          trailing: Text(animal.name),
          onTap: () {
            abrirProntuario(animal);
          },
        );
      },
    );
  }

  List<Animal> filtrarRebanhoByQuery() {
    return rebanho
        .where((person) =>
            person.nBrinco.toLowerCase().contains(this.query.toLowerCase()))
        .toList();
  }
}
