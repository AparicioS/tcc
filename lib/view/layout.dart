import 'package:flutter/material.dart';

class Cor {
  static Color erro([double opacity = 1]) =>
      Color.fromRGBO(178, 34, 34, opacity);
  static Color titulo([double opacity = 1]) =>
      Color.fromRGBO(36, 9, 205, opacity);
  static Color cabecario([double opacity = 1]) =>
      Color.fromRGBO(113, 194, 74, opacity);
  static Color backgrud([double opacity = 1]) =>
      Color.fromRGBO(231, 244, 192, opacity);
  static Color botaoverde([double opacity = 1]) =>
      Color.fromRGBO(39, 174, 96, opacity);
  static Color botaoAzul([double opacity = 0.9]) =>
      Color.fromRGBO(17, 116, 255, opacity);
}

class ScaffoldLayout extends Scaffold {
  ScaffoldLayout({Widget body, acoes, floatingActionButton})
      : super(
            appBar: AppBar(
              backgroundColor: Cor.cabecario(),
              title: Center(
                child: Text('Diagnostico Bovino',
                    style: TextStyle(color: Cor.titulo(), fontSize: 30)),
              ),
              actions: acoes,
            ),
            body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('imagens/fundoHome.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                padding: EdgeInsets.all(5),
                child: body),
            floatingActionButton: floatingActionButton);
}

class BotaoRodape extends FlatButton {
  BotaoRodape({onLongPress, onPressed, child})
      : super(
            textColor: Colors.white,
            onLongPress: onLongPress,
            onPressed: onPressed,
            child: Container(
                width: 120,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Cor.botaoAzul(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    )),
                child: child));
}

class AcaoTopo extends Container {
  AcaoTopo({onPressed, icone, texto})
      : super(
          height: 20,
          child: Align(
            alignment: Alignment.bottomRight,
            child: FlatButton.icon(
                label: Text(texto,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    )),
                icon: Icon(icone),
                textColor: Cor.botaoAzul(),
                onPressed: onPressed),
          ),
        );
}
