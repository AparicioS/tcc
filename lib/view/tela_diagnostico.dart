import 'package:diagnostico_bovino/view/layout.dart';
import 'package:flutter/material.dart';

class TelaDiagnostico extends StatefulWidget {
  @override
  _TelaDiagnosticoState createState() => _TelaDiagnosticoState();
}

class _TelaDiagnosticoState extends State<TelaDiagnostico> {
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
          child: Text("Proximo"),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => TelaDiagnostico()));
          },
        ));
  }
}
