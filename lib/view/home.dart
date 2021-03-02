import 'package:diagnostico_bovino/controller/controller_home.dart';
import 'package:diagnostico_bovino/model/usuario.dart';
import 'package:diagnostico_bovino/view/layout.dart';
import 'package:diagnostico_bovino/view/tela_diagnostico_dados_animal.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Usuario().resetUsuario();
    final String titulo =
        'Sistema de Analise de Sintomas para Diagnostico em Bovinos';
    final String paragrafo =
        'O sistema apresenta possiveis diagnosticos e idica opções de tratamentos atravez de breve analise de sintomas e informações referentes ao animal \n\n O cadastro permite o acompanhamento do rebanhos mantendo o historico de ganho ou perca de peso bem como, doenças, vacinas e tratamentos aplicados a cada animal.';
    return ScaffoldLayout(
      body: Container(
        child: ListView(
          children: [
            AcaoTopo(
                icone: Icons.login,
                texto: 'Entrar',
                onPressed: () => ControllerHome.entrar(context)),
            Container(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Title(
                      color: Colors.black,
                      child: Text(
                        titulo,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      child: Text(
                        paragrafo,
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BotaoRodape(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => TelaDiagnosticoDadosAnimal()));
          },
          child: Text("Diagnostico")),
    );
  }
}
