import 'package:diagnostico_bovino/view/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LitAuthInit(
        authProviders: AuthProviders(emailAndPassword: true, google: true),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: [const Locale('pt', 'BR')],
          home: Home(),
        ),
      )));
}
