import 'package:diagnostico_bovino/view/layout.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

class TelaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldLayout(
        body: Container(
      child: LitAuth(
        config: AuthConfig(
          title: Text('Login', style: TextStyle(fontSize: 30)),
          emailTextField: TextFieldConfig(
              style: TextStyle(fontSize: 20),
              inputDecoration: InputDecoration(labelText: 'Email:')),
          passwordTextField: TextFieldConfig(
              style: TextStyle(fontSize: 20),
              inputDecoration: InputDecoration(labelText: 'Senha:')),
          googleButton:
              GoogleButtonConfig.dark(label: Text('Entrar usando Google')),
          signInButton: ButtonConfig.raised(
            themedata: ButtonThemeData(buttonColor: Cor.botaoAzul()),
            child: Text(
              'Entrar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        errorNotification: NotificationConfig(backgroundColor: Cor.erro()),
      ),
    ));
  }
}
