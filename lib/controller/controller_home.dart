import 'package:diagnostico_bovino/view/tela_login.dart';
import 'package:diagnostico_bovino/view/tela_pricipal.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class ControllerHome {
  static entrar(context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => LitAuthState(
            authenticated: TelaPricipal(), unauthenticated: TelaLogin())));
  }
}
