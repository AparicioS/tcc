import 'package:diagnostico_bovino/controller/controller_diagnostico.dart';
import 'package:diagnostico_bovino/view/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SintomasSearchDelegate extends SearchDelegate {
  ControllerDiagnostico controller;
  SintomasSearchDelegate({String hintText, this.controller})
      : super(
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
    return buildListSintomas(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildListSintomas(context);
  }

  Widget buildListSintomas(BuildContext context) {
    List<String> sintoma = controller
        .getListSintoma()
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
}
