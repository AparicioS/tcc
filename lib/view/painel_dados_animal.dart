import 'package:diagnostico_bovino/model/animal.dart';
import 'package:diagnostico_bovino/util/data_util.dart';
import 'package:flutter/cupertino.dart';

import 'layout.dart';

class PainelDadosAnimal extends Container {
  PainelDadosAnimal({Animal animal})
      : super(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              alignment: Alignment.topLeft,
              child: Title(
                  color: Cor.titulo(),
                  child: Text(
                    'Dados do Animal',
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.topCenter,
                child: Table(children: [
                  TableRow(children: [
                    Text('Numero do brinco:'),
                    Text(animal.nBrinco),
                  ]),
                  TableRow(children: [
                    Text('Nome/identificação:'),
                    Text(animal.name ?? ''),
                  ]),
                  TableRow(children: [
                    Text('Raça:'),
                    Text(animal.raca ?? ''),
                  ]),
                  TableRow(children: [
                    Text('Idade:'),
                    Text(
                        DataUtil.idadebyDataNascimento(animal.dataNascimento) ??
                            ''),
                  ]),
                  TableRow(children: [
                    Text('Sexo:'),
                    Text(animal.sexo ?? ''),
                  ]),
                ])),
          ],
        ));
}
