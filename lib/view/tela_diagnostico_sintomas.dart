import 'package:diagnostico_bovino/controller/controller_diagnostico.dart';
import 'package:diagnostico_bovino/view/tela_diagnostico.dart';
import 'package:diagnostico_bovino/view/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaDiagnosticoSintomas extends StatefulWidget {
  @override
  _TelaDiagnosticoSintomasState createState() =>
      _TelaDiagnosticoSintomasState();
}

class _TelaDiagnosticoSintomasState extends State<TelaDiagnosticoSintomas> {
  ControllerDiagnostico ctrlDiagnostico;
  @override
  void initState() {
    setState(() {
      ctrlDiagnostico = new ControllerDiagnostico();
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
                      context: context, delegate: ctrlDiagnostico.getDelegate())
                  .then((value) {
                if (value != null) {
                  setState(() {
                    ctrlDiagnostico.addSintomas(value);
                  });
                }
              }),
            ),
          ),
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount:
                  ctrlDiagnostico.getSintomas().length, // sintomas.length,
              itemBuilder: (context, index) {
                var sintomas = ctrlDiagnostico.getSintomas();
                return ListTile(
                  title: Text(sintomas[index]),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          ctrlDiagnostico.removeSintomas(sintomas[index]);
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
            if (ctrlDiagnostico.isListSintomas()) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => TelaDiagnostico(),
                  settings: RouteSettings(
                      arguments: ctrlDiagnostico.getDoencafromSintomas())));
            } else {
              showDialog(
                  context: context,
                  builder: (contx) {
                    return CupertinoAlertDialog(
                      title: Text('Diagnostico'),
                      content: Text(
                          'para emissão de diagnostico é necessario informar algum sintoma'),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(contx),
                            child: Text('OK'))
                      ],
                    );
                  });
            }
          },
          child: Text("Proximo")),
    );
  }
}
