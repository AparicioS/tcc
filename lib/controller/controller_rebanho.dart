import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diagnostico_bovino/model/usuario.dart';

class ControllerRebanho {
  static cadastrarRebanho(rebanho) {
    FirebaseFirestore.instance
        .collection('Rebanho')
        .doc(Usuario().id)
        .set(rebanho.toMap());
  }

  static cadastrarAnimal(animal) {
    FirebaseFirestore.instance
        .collection('Rebanho')
        .doc(Usuario().id)
        .collection('Animais')
        .doc(animal.nBrinco)
        .set(animal.toMap());
  }

  static cadastrarPesagem(animal, data, peso) {
    FirebaseFirestore.instance
        .collection('Rebanho')
        .doc(Usuario().id)
        .collection('Animais')
        .doc(animal.nBrinco)
        .collection('peso')
        .doc()
        .set({'data': data, 'peso': peso});
  }

  static cadastrarTratamento(animal, aplicacao) {
    FirebaseFirestore.instance
        .collection('Rebanho')
        .doc(Usuario().id)
        .collection('Animais')
        .doc(animal.nBrinco)
        .collection('tratamento')
        .doc()
        .set(aplicacao.toMap());
  }
}
