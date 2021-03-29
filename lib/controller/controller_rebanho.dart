import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diagnostico_bovino/model/usuario.dart';

class ControllerRebanho {
  static cadastrarRebanho(rebanho) {
    if (Usuario().id == null) {
      return 'Falha ';
    }
    return FirebaseFirestore.instance
        .collection('Rebanho')
        .doc(Usuario().id)
        .set(rebanho.toMap())
        .then((value) => 'Sucesso ')
        .catchError((erro) => 'Falha ');
  }

  static cadastrarAnimal(animal) {
    if (Usuario().id == null) {
      return 'Falha ';
    }
    return FirebaseFirestore.instance
        .collection('Rebanho')
        .doc(Usuario().id)
        .collection('Animais')
        .doc(animal.nBrinco)
        .set(animal.toMap())
        .then((value) => 'Sucesso ')
        .catchError((erro) => 'Falha ');
  }

  static cadastrarManejo(animal, manejo) {
    FirebaseFirestore.instance
        .collection('Rebanho')
        .doc(Usuario().id)
        .collection('Animais')
        .doc(animal.nBrinco)
        .collection('manejo')
        .doc()
        .set(manejo.toMap())
        .then((value) => 'Sucesso ')
        .catchError((erro) => 'Falha ');
  }

  static cadastrarTratamento(animal, tatamento) {
    if (Usuario().id == null) {
      return 'Falha ';
    }
    FirebaseFirestore.instance
        .collection('Rebanho')
        .doc(Usuario().id)
        .collection('Animais')
        .doc(animal.nBrinco)
        .collection('tratamento')
        .doc(tatamento.id)
        .set(tatamento.toMap())
        .then((value) => 'Sucesso ')
        .catchError((erro) => 'Falha ');
  }
}
