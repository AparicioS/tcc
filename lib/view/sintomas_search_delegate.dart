import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diagnostico_bovino/model/animal.dart';
import 'package:diagnostico_bovino/model/usuario.dart';
import 'package:diagnostico_bovino/util/data_util.dart';
import 'package:diagnostico_bovino/view/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SintomasSearchDelegate extends SearchDelegate {
  SintomasSearchDelegate({
    String hintText,
  }) : super(
          searchFieldLabel: hintText,
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Cor.cabecario(),
      primaryIconTheme: theme.primaryIconTheme.copyWith(),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    DateTime.now();
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
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Rebanho')
          .doc(Usuario().id)
          .collection('Animais')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapsho) {
        switch (snapsho.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
            break;
          case ConnectionState.done:
            return Center(child: CircularProgressIndicator());
            break;
          default:
            if (snapsho.data.docs.length == 0) {
              print('lista vazia');
            }
            List<Animal> rebanho = snapsho.data.docs
                .map((doc) => Animal.fromDoc(doc))
                .where((animal) => animal.nBrinco
                    .toLowerCase()
                    .contains(this.query.toLowerCase()))
                .toList();
            return ListView.builder(
              itemCount: rebanho.length,
              itemBuilder: (context, index) {
                Animal animal = rebanho[index];
                return ListTile(
                  leading: Text(animal.nBrinco),
                  title: Text(animal.name),
                  subtitle: Text(animal.sexo ?? ''),
                  trailing: Text(
                      DataUtil.idadebyDataNascimento(animal.dataNascimento)),
                  onTap: () {
                    this.close(context, animal);
                  },
                );
              },
            );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> sintoma = sintomas
        .where((element) =>
            element.toLowerCase().contains(this.query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: sintoma.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(sintoma[index]),
          onTap: () {
            this.close(context, sintoma[index]);
          },
        );
      },
    );
  }

  var sintomas = [
    'inflamação das mucosas',
    'inflamação da glândula mamária',
    'hemorragia',
    'edemas generalizados'
  ];
}
