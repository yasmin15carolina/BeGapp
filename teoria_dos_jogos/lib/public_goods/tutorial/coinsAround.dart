import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/classes/soundEffects.dart';

class CoinsAround extends StatelessWidget {
  final double screenHeight;
  final Function coinsEndAnimation;
  final Function coinsToCenter;
  final Function coinsOutCenter;
  final bool toCenter;
  CoinsAround(this.screenHeight, this.coinsEndAnimation, this.coinsToCenter,
      this.coinsOutCenter, this.toCenter);
  @override
  Widget build(BuildContext context) {
    List<Alignment> alignments = (toCenter)
        ? [
            Alignment.topLeft,
            Alignment.centerLeft,
            Alignment.bottomLeft,
            Alignment.topRight,
            Alignment.centerRight,
            Alignment.bottomRight
          ]
        : [
            Alignment.bottomRight,
            Alignment.centerRight,
            Alignment.topRight,
            Alignment.bottomLeft,
            Alignment.centerLeft,
            Alignment.topLeft
          ];
    return Stack(children: [
      Container(
          alignment: alignments[0],
          child: Transform(
            // Transform widget
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateZ(60)
              ..rotateX(60),
            alignment: FractionalOffset.center,
            child: Container(
                height: screenHeight * 0.3 * 2,
                width: screenHeight,
                //color: Colors.green.withOpacity(0.5),
                child: FlareActor(
                  'assets/flare/Coins.flr',
                  alignment: Alignment.center,
                  animation: 'Collect',
                  fit: BoxFit.contain,
                  callback: (name) {
                    coinsEndAnimation();
                    toCenter ? coinsToCenter() : coinsOutCenter();
                  },
                )),
          )),
      Container(
          alignment: alignments[1],
          child: Transform(
            // Transform widget
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              //..rotateX(90)
              ..rotateY(60),
            alignment: FractionalOffset.center,
            child: Container(
                height: screenHeight * 0.3 * 2,
                width: screenHeight,
                //color: Colors.green.withOpacity(0.5),
                child: FlareActor(
                  'assets/flare/Coins.flr',
                  alignment: Alignment.center,
                  animation: 'Collect',
                  fit: BoxFit.contain,
                  callback: (name) async {
                    SoundEffects.play('audio/CollectCoin.mp3');
                  },
                )),
          )),
      Container(
          alignment: alignments[2],
          child: Transform(
            // Transform widget
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateZ(-60),
            alignment: FractionalOffset.center,
            child: Container(
                height: screenHeight * 0.3 * 2,
                width: screenHeight,
                //color: Colors.green.withOpacity(0.5),
                child: FlareActor(
                  'assets/flare/Coins.flr',
                  alignment: Alignment.center,
                  animation: 'Collect',
                  fit: BoxFit.contain,
                  callback: (name) {},
                )),
          )),
      Container(
        alignment: alignments[3],
        child: Transform.rotate(
          // Transform widget
          angle: -pi / 9,
          child: Container(
              height: screenHeight * 0.3 * 2,
              width: screenHeight,
              //color: Colors.green.withOpacity(0.5),
              child: FlareActor(
                'assets/flare/Coins.flr',
                alignment: Alignment.center,
                animation: 'Collect',
                fit: BoxFit.contain,
                callback: (name) {},
              )),
        ),
      ),
      Container(
        alignment: alignments[4],
        child:
            // Transform.rotate(  // Transform widget
            //   angle:-pi/9,
            //   child:
            Container(
                height: screenHeight * 0.3 * 2,
                width: screenHeight,
                //color: Colors.green.withOpacity(0.5),
                child: FlareActor(
                  'assets/flare/Coins.flr',
                  alignment: Alignment.center,
                  animation: 'Collect',
                  fit: BoxFit.contain,
                  callback: (name) {},
                )),

        //),
      ),
      Container(
        alignment: alignments[5],
        child: Transform.rotate(
          // Transform widget
          angle: pi / 9,
          child: Container(
              height: screenHeight * 0.3 * 2,
              width: screenHeight,
              //color: Colors.green.withOpacity(0.5),
              child: FlareActor(
                'assets/flare/Coins.flr',
                alignment: Alignment.center,
                animation: 'Collect',
                fit: BoxFit.contain,
                callback: (name) {},
              )),
        ),
      ),
    ]);
  }
}
