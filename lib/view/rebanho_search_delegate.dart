import 'package:diagnostico_bovino/model/animal.dart';
import 'package:diagnostico_bovino/util/data_util.dart';
import 'package:diagnostico_bovino/view/layout.dart';
import 'package:flutter/material.dart';

class RebanhoSearchDelegate extends SearchDelegate {
  RebanhoSearchDelegate({
    String hintText,
  }) : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.number,
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

  static List<Animal> rebanho = [
    Animal('boi 1', '165216511651', 'femea', DateTime.now(), 'raça'),
    Animal('boi 2', '165216511651', 'femea', DateTime(2020, 1, 21), 'raça'),
    Animal('boi 3', '166116511651', 'macho', DateTime(2020, 1, 22), 'raça'),
    Animal('boi 4', '166116511651', 'femea', DateTime(2020, 1, 25), 'raça'),
    Animal('boi 5', '175116511651', 'macho', DateTime(2020, 2, 21), 'raça'),
    Animal('boi 6', '175116511651', 'femea', DateTime(2020, 2, 22), 'raça'),
    Animal('boi 7', '175116511651', 'femea', DateTime(2020, 2, 25), 'raça'),
    Animal('boi 8', '265116511651', 'macho', DateTime(2020, 3, 21), 'raça'),
    Animal('boi 9', '265116511651', 'macho', DateTime(2020, 3, 22), 'raça'),
    Animal('boi 10', '265116511651', 'macho', DateTime(2020, 3, 25), 'raça'),
    Animal('boi 10', '265116511651', 'macho', DateTime(2020, 2, 20), 'raça'),
  ];

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
    return ListView.builder(
      itemCount: filtrarRebanhoByQuery().length,
      itemBuilder: (context, index) {
        Animal animal = filtrarRebanhoByQuery()[index];
        return ListTile(
          leading: Text(animal.nBrinco),
          title: Text(animal.name),
          subtitle: Text(animal.sexo),
          trailing: Text(DataUtil.idadebyDataNascimento(animal.dataNascimento)),
          onTap: () {
            this.close(context, animal);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: filtrarRebanhoByQuery().length,
      itemBuilder: (context, index) {
        Animal animal = filtrarRebanhoByQuery()[index];
        return ListTile(
          title: Text(animal.nBrinco),
          trailing: Text(animal.name),
          onTap: () {
            this.close(context, animal);
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
