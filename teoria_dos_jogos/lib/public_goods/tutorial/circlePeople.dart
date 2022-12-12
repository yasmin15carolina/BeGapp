import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';
import 'package:teoria_dos_jogos/public_goods/store/round_data_store.dart';
import 'package:teoria_dos_jogos/public_goods/tutorial/coinsAround.dart';

class CirclePeople extends StatefulWidget {
  final bool show; // = false;
  final Function multipleCoinsEnd;
  final bool toCenter;
  final PublicGoodsVariables variables;

  CirclePeople(this.show, this.multipleCoinsEnd, this.toCenter, this.variables);

  @override
  _CirclePeopleState createState() => _CirclePeopleState();
}

class _CirclePeopleState extends State<CirclePeople> {
  //final PublicGoodsVariables variables = new PublicGoodsVariables(maxTrys: 10, maxChips: 10, factor: 3, notRealPlayers: 5);
  RoundData roundData = new RoundData();

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  coinsToCenter() {
    setState(() {
      roundData.investment = Random().nextInt(11);
      roundData.generateRound(widget.variables);
      cardKey.currentState!.toggleCard();
    });
  }

  coinsOutCenter() {}

  @override
  Widget build(BuildContext context) {
    double screenHeight = Resize.getHeight(context);
    double screenWidth = Resize.getWidth(context);
    return Scaffold(
      body: Center(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            children: [
              FlipCard(
                flipOnTouch: false,
                direction: FlipDirection.HORIZONTAL,
                key: cardKey,
                front: Center(
                    child: Image.asset(
                  "assets/images/moneyPig.png",
                  scale: 411 / screenHeight,
                )),
                back: Center(
                  child: Container(
                      alignment: Alignment.center,
                      height: screenHeight * 0.5,
                      child: Image.asset(
                        "assets/images/coinsBag.png",
                        // scale: screenHeight / 90,
                      )),
                ),
                // Center(
                //     child:Text(
                //       roundData.rib.toString(),
                //       style:TextStyle(
                //         fontSize: fontsize*2
                //       ),
                //     )
                // )
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/people/Femaleb.png",
                        scale: 2000 / screenHeight,
                      ),
                      Image.asset(
                        "assets/people/FemaleR.png",
                        scale: 2000 / screenHeight,
                      ),
                      Image.asset(
                        "assets/people/MaleMoustache.png",
                        scale: 2000 / screenHeight,
                      ),
                    ]),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/people/Malew.png",
                        scale: 2000 / screenHeight,
                      ),
                      Image.asset(
                        "assets/people/FemaleGlasses.png",
                        scale: 2000 / screenHeight,
                      ),
                      Image.asset(
                        "assets/people/Maleb.png",
                        scale: 2000 / screenHeight,
                      ),
                    ]),
              ]),
              if (widget.show)
                new CoinsAround(screenHeight, widget.multipleCoinsEnd,
                    coinsToCenter, coinsOutCenter, widget.toCenter),
              // Instruction(AppLocalizations.of(context).translate('pGInstruction15'),
              //   false,null,
              //   width: containerWidth,alignment: Alignment.topCenter,),
            ],
          ),
        ),
      ),
    );
  }
}
