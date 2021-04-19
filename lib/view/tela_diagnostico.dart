import 'package:diagnostico_bovino/model/doenca.dart';
import 'package:diagnostico_bovino/view/layout.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class TelaDiagnostico extends StatefulWidget {
  @override
  _TelaDiagnosticoState createState() => _TelaDiagnosticoState();
}

class _TelaDiagnosticoState extends State<TelaDiagnostico> {
  String resusltado;
  String sintomas;
  String caracteristica;
  String causas;
  String tratamento;
  String referencia;
  @override
  void didChangeDependencies() {
    List<Doenca> doencas = ModalRoute.of(context).settings.arguments;
    switch (doencas.length) {
      case 0:
        resusltado =
            'Não foram encontrados resultado com base nos parametros informados';
        sintomas = '';
        caracteristica = '';
        causas = '';
        tratamento = '';
        referencia = '';
        break;
      case 1:
        resusltado = doencas[0].nome + '\n\nSintomas: ' + doencas[0].sintomas;
        caracteristica = doencas[0].caracteristicas;
        causas = doencas[0].causas;
        tratamento = doencas[0].tratamento;
        referencia = doencas[0].referencia;
        break;
      default:
        resusltado =
            'Para um resultado mais preciso informe mais sintomas.\nOs sintomas informados são recorentes em pelo menos ' +
                doencas.length.toString() +
                ' doenças:';
        for (var item in doencas) {
          resusltado += '\n ' + item.nome;
        }
        caracteristica = '';
        causas = '';
        tratamento = '';
        referencia = '';
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldLayout(
        body: ListView(
          children: [
            SizedBox(height: 30),
            Center(
                child: Text(
              "Diagnostico",
              style: TextStyle(fontSize: 30),
            )),
            SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Resultados:',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(alignment: Alignment.topLeft, child: Text(resusltado)),
                ],
              ),
            ),
            Visibility(
              visible: tratamento.isNotEmpty,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Caracteristicas:',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(caracteristica)),
                    ],
                  ),
                  SizedBox(height: 30),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Possiveis causas:',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(alignment: Alignment.topLeft, child: Text(causas)),
                    ],
                  ),
                  SizedBox(height: 30),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Recomendação:',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(tratamento)),
                    ],
                  ),
                  SizedBox(height: 30),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Referencia:',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(referencia)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: BotaoRodape(
            child: Text("Fechar"),
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => Home()), (e) => false)));
  }
}
