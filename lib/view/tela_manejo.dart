import 'package:diagnostico_bovino/controller/controller_rebanho.dart';
import 'package:diagnostico_bovino/model/animal.dart';
import 'package:diagnostico_bovino/model/manejo.dart';
import 'package:diagnostico_bovino/util/data_util.dart';
import 'package:diagnostico_bovino/view/layout.dart';
import 'package:diagnostico_bovino/view/painel_dados_animal.dart';
import 'package:flutter/material.dart';

class TelaManejo extends StatefulWidget {
  @override
  _TelaManejoState createState() => _TelaManejoState();
}

class _TelaManejoState extends State<TelaManejo> {
  Animal animal;
  Manejo manejo;

  @override
  void didChangeDependencies() {
    manejo = Manejo.novo();
    manejo.atividade = 'pesagem';
    setState(() {
      animal = ModalRoute.of(context).settings.arguments;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var form = GlobalKey<FormState>();
    return ScaffoldLayout(
        body: Form(
          key: form,
          child: ListView(
            children: [
              SizedBox(
                height: 50,
                child: Center(
                  child: Title(
                      title: 'Pesagem',
                      color: Cor.titulo(),
                      child: Text(
                        "Pesagem",
                        style: TextStyle(fontSize: 30),
                      )),
                ),
              ),
              PainelDadosAnimal(animal: animal),
              SizedBox(height: 30),
              // campo data de aplica
              DataUtil.campoData('Data:',
                  (valor) => manejo.data = valor.add(Duration(hours: 3))),
              SizedBox(height: 30),
              // campo medicamento
              TextFormField(
                onSaved: (valor) => manejo.valor = valor,
                validator: (valor) {
                  if (valor.isEmpty) {
                    return 'campo obrigatorio';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Peso/Kg:'),
              ),
            ],
          ),
        ),
        floatingActionButton: BotaoRodape(
          child: Text("Salvar"),
          onPressed: () async {
            if (form.currentState.validate()) {
              form.currentState.save();
              await ControllerRebanho.cadastrarManejo(animal, manejo);
              Navigator.pop(context);
            }
          },
        ));
  }
}
