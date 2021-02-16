import 'package:diagnostico_bovino/view/layout.dart';
import 'package:diagnostico_bovino/view/tela_diagnostico.dart';
import 'package:flutter/material.dart';

class TelaDiagnosticoSintomas extends StatefulWidget {
  @override
  _TelaDiagnosticoSintomasState createState() =>
      _TelaDiagnosticoSintomasState();
}

class _TelaDiagnosticoSintomasState extends State<TelaDiagnosticoSintomas> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldLayout(
      body: ListView(
        children: [
          Center(
              child: Text(
            "Sintomas",
            style: TextStyle(fontSize: 30),
          )),
          SizedBox(height: 30),
          TextField(
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(labelText: "Sintoma:"),
          ),
          SizedBox(height: 30),
          TextField(
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(labelText: "Sintoma relacionado:"),
          ),
          SizedBox(height: 30),
        ],
      ),
      floatingActionButton: BotaoRodape(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => TelaDiagnostico()));
          },
          child: Text("Proximo")),
    );
  }
}
