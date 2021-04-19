import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diagnostico_bovino/model/doenca.dart';
import 'package:diagnostico_bovino/view/sintomas_search_delegate.dart';

class ControllerDiagnostico {
  List<Doenca> doencas;
  List<String> sintomas;
  ControllerDiagnostico() {
    doencas = buscarDoencas();
    sintomas = [];
  }
  SintomasSearchDelegate getDelegate() {
    return new SintomasSearchDelegate(controller: this);
  }

  List<Doenca> getDoencas() {
    return doencas == null ? doencas = buscarDoencas() : doencas;
  }

  List<String> getSintomas() {
    return sintomas == null ? sintomas = [] : sintomas;
  }

  addSintomas(sintomoma) {
    sintomas.add(sintomoma);
  }

  removeSintomas(String sintomoma) {
    sintomas.remove(sintomoma);
  }

  List<String> getListSintoma() {
    List<String> lista = listarSintomas(getDoencafromSintomas());
    for (var item in getSintomas()) {
      lista.remove(item);
    }
    lista.sort();
    return lista;
  }

  List<Doenca> getDoencafromSintomas() {
    List<Doenca> doencasFromSintoma = getDoencas();
    for (var item in sintomas) {
      doencasFromSintoma = doencasFromSintoma
          .where((doenca) =>
              doenca.sintomas.toLowerCase().contains(item.toLowerCase()))
          .toList();
    }
    return doencasFromSintoma;
  }

  bool isListSintomas() {
    return sintomas.isNotEmpty;
  }

/* remover para a classe ControllerDoenca*/
  static List<String> listarSintomas(doencas) {
    Set<String> sintomas = new Set();
    if (doencas == null) {
      return [];
    }
    for (var doenca in doencas) {
      sintomas.addAll(doenca.sintomas.split(','));
    }
    return sintomas.toList();
  }

  static List<Doenca> buscarDoencas() {
    List<Doenca> doencas = [];
    FirebaseFirestore.instance.collection('doencas').get().then((value) {
      doencas.addAll(value.docs.map((doc) => Doenca.fromDoc(doc)).toList());
      return doencas;
    });
    return doencas;
  }
}
