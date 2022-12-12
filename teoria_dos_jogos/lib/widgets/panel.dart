//import 'package:bens_publicos/store/game_store.dart';
import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
//import 'package:flutter_mobx/flutter_mobx.dart';

class Panel extends StatelessWidget {
  final String title;
  final Widget label;
  final double fontsize;
  //final Game game = new Game();
  Panel(this.fontsize, {required this.title, required this.label});
  @override
  Widget build(BuildContext context) {
    double screenHeight = Resize.getHeight(context);
    double squadHeight = screenHeight / 8;
    double squasWidth = screenHeight / 6;
    // double fontsize = screenHeight / 30;
    return
        // Container(
        //   color: Colors.white,
        //   child:
        Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // Observer(builder: (_) {
        //   return RaisedButton(
        //       child: Text(game.roundData.factor.toString()),
        //       onPressed: game.testando );
        // }),
        Container(
          height: squadHeight,
          width: squasWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.red, width: screenHeight / 143)),
          child: Center(child: label),
        ),
        Text(
          title,
          style: TextStyle(fontSize: fontsize),
          textAlign: TextAlign.center,
        )
      ],
      //)
    );
  }
}
