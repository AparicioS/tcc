import 'package:diagnostico_bovino/view/layout.dart';
import 'package:diagnostico_bovino/view/sintomas_search_delegate.dart';
import 'package:diagnostico_bovino/view/tela_diagnostico.dart';
import 'package:flutter/material.dart';

class TelaDiagnosticoSintomas extends StatefulWidget {
  @override
  _TelaDiagnosticoSintomasState createState() =>
      _TelaDiagnosticoSintomasState();
}

class _TelaDiagnosticoSintomasState extends State<TelaDiagnosticoSintomas> {
  List<String> sintomas;
  @override
  void initState() {
    setState(() {
      sintomas = [];
    });
    super.initState();
  }

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
          ListTile(
            title: Title(
                color: Cor.titulo(),
                child: Text(
                  'Sintomas:',
                  style: TextStyle(fontSize: 20),
                )),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () => showSearch(
                      context: context, delegate: SintomasSearchDelegate())
                  .then((value) {
                setState(() {
                  sintomas.add(value);
                });
              }),
            ),
          ),
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: sintomas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(sintomas[index]),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          sintomas.remove(sintomas[index]);
                        });
                      }),
                );
              },
            ),
          ),
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
