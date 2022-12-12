import 'package:circle_list/circle_list.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/classes/soundEffects.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';

import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/public_goods/widgets/token.dart';
import 'package:teoria_dos_jogos/widgets/clock.dart';
import 'package:teoria_dos_jogos/widgets/panel.dart';
import 'package:teoria_dos_jogos/widgets/timer.dart';

class PublicGoodsTimer extends StatefulWidget {
  final PublicGoodsVariables variables;
  PublicGoodsTimer(this.variables);
  @override
  _PublicGoodsTimerState createState() => _PublicGoodsTimerState();
}

class _PublicGoodsTimerState extends State<PublicGoodsTimer> {
  //RoundData roundData = new RoundData(nPlayers: 5,factor: 3);
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  List<int> chipsList = []; // List<int>.of([0,1,2,3,4,5,6,7,8,9,10]);
  bool showCoins = false;
  bool isDraggable = true;
  String animationClock = "Pulse";
  bool startTiming = true;

  @override
  void initState() {
    for (int i = 0; i < 10 + 1; i++) {
      if (widget.variables.maxTokens > 10) {
        chipsList.add((i * (widget.variables.maxTokens / 10)).toInt());
      } else
        chipsList.add(i);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = Resize.getHeight(context);
    double fontsize = screenHeight / 20;
    return Scaffold(
      body: Center(
        child: Container(
            height: screenHeight,
            width: Resize.getWidth(context),
            child: Stack(children: [
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        //Clock
                        Column(
                          children: <Widget>[
                            Clock(animation: animationClock),
                            TimerCount(
                              time: 3,
                              animationEnds: () {
                                setState(() {
                                  animationClock = "Shake";
                                  startTiming = false;
                                  SoundEffects.play('audio/ClockBell.mp3');
                                  Future.delayed(Duration(seconds: 2),
                                      () async {
                                    setState(() {
                                      animationClock = "Stop";
                                    });
                                  });
                                });
                              },
                              start: startTiming,
                            ),
                          ],
                        ),
                        Panel(
                          fontsize,
                          title:
                              AppLocalizations.of(context).translate('wallet'),
                          label:
                              Text("0", style: TextStyle(fontSize: fontsize)),
                        ),
                        Panel(
                          fontsize,
                          title:
                              AppLocalizations.of(context).translate('chips'),
                          label: Text(widget.variables.maxTokens.toString(),
                              style: TextStyle(fontSize: fontsize)),
                        ),
                        if (widget.variables.showRounds)
                          Text(
                            AppLocalizations.of(context).translate('round') +
                                ": 1", //+roundData.round.toString(),
                            style: TextStyle(fontSize: fontsize),
                          )
                      ],
                    ),
                  ), //),

                  CircleList(
                    rotateMode: RotateMode.stopRotate,
                    origin: Offset(0, 0),
                    outerRadius: Resize.getHeight(context) * 0.5,
                    centerWidget:
                        //Imagem do Cofrinho
                        DragTarget<int>(
                      onAccept: null,
                      builder: (context, candidates, rejects) {
                        return FlipCard(
                            flipOnTouch: false,
                            direction: FlipDirection.HORIZONTAL,
                            key: cardKey,
                            front: Center(
                                child: Container(
                                    child: Image.asset(
                              "assets/images/moneyPig.png",
                              scale: 411 / screenHeight,
                            ))),
                            back: Container(
                                child: Center(
                                    // child:Text(
                                    //   roundData.rib.toString(),
                                    //   style:TextStyle(
                                    //     fontSize: fontsize*2
                                    //   ),
                                    // )
                                    )));
                      },
                    ),
                    children: List.generate(chipsList.length, (index) {
                      return GameToken(
                        list: chipsList,
                        round: 1,
                        value: (index >= 8)
                            ? chipsList[index - 8]
                            : chipsList[index + 3],
                        maxValue: widget.variables.maxTokens,
                        isDraggable: isDraggable,
                      );
                    }),
                  ),

                  Expanded(
                    child: Column(children: [
                      Padding(
                          padding: EdgeInsets.only(right: 5, top: 10),
                          child: Panel(
                            fontsize,
                            title: AppLocalizations.of(context)
                                .translate('didntPlayYet'),
                            label: Text(
                                widget.variables.notRealPlayers.toString(),
                                style: TextStyle(fontSize: fontsize)),
                          ))
                    ]),
                  )
                ],
              ),
            ])),
      ),
    );
  }
}
