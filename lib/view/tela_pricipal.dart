import 'package:diagnostico_bovino/model/usuario.dart';
import 'package:diagnostico_bovino/view/layout.dart';
import 'package:diagnostico_bovino/view/rebanho_search_delegate.dart';
import 'package:diagnostico_bovino/view/tela_cadastro_animal.dart';
import 'package:diagnostico_bovino/view/tela_cadastro_rebanho.dart';
import 'package:diagnostico_bovino/view/tela_diagnostico_sintomas.dart';
import 'package:diagnostico_bovino/view/tela_manejo.dart';
import 'package:diagnostico_bovino/view/tela_prontuario.dart';
import 'package:diagnostico_bovino/view/tela_tratamento.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class TelaPricipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Usuario().caregaUsuarioLitUser(context.getSignedInUser());
    final sizewidth = MediaQuery.of(context).size.width;
    final sizeheight = (MediaQuery.of(context).size.height -
        (kToolbarHeight + MediaQuery.of(context).padding.top));
    final double _imagemWidthSize = sizewidth * 0.5;
    final double _imagemHeightSize = sizeheight * 0.20;
    final double _fonteSize = 25;

    abrirProntuario(animal) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => TelaProntuario(),
          settings: RouteSettings(arguments: animal)));
    }

    abrirTratamento(animal) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => TelaTratamento(),
          settings: RouteSettings(arguments: animal)));
    }

    abrirManejo(animal) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => TelaManejo(),
          settings: RouteSettings(arguments: animal)));
    }

    abrirDiagnostico(animal) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => TelaDiagnosticoSintomas(),
          settings: RouteSettings(arguments: animal)));
    }

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
                              delegate: RebanhoSearchDelegate())
                          .then((value) =>
                              value != null ? abrirProntuario(value) : null),
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
                      onPressed: () => showSearch(
                              context: context,
                              delegate: RebanhoSearchDelegate())
                          .then((value) =>
                              value != null ? abrirManejo(value) : null),
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
                      onPressed: () => showSearch(
                              context: context,
                              delegate: RebanhoSearchDelegate())
                          .then((value) =>
                              value != null ? abrirDiagnostico(value) : null),
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
                      onPressed: () => showSearch(
                              context: context,
                              delegate: RebanhoSearchDelegate())
                          .then((value) =>
                              value != null ? abrirTratamento(value) : null),
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
