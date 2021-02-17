import 'package:diagnostico_bovino/model/animal.dart';
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
