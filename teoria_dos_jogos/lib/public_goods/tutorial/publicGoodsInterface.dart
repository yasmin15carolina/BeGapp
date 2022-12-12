import 'package:circle_list/circle_list.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/classes/rotation.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';
import 'package:teoria_dos_jogos/public_goods/store/round_data_store.dart';

import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/public_goods/widgets/token.dart';
import 'package:teoria_dos_jogos/widgets/clock.dart';
import 'package:teoria_dos_jogos/widgets/panel.dart';

// ignore: must_be_immutable
class PublicGoodsTutorial extends StatefulWidget {
  Function? function;
  final PublicGoodsVariables variables;
  final bool tutorialDistElection;
  PublicGoodsTutorial(this.function, this.variables,
      {this.tutorialDistElection: false});
  @override
  _PublicGoodsTutorialState createState() => _PublicGoodsTutorialState();
}

class _PublicGoodsTutorialState extends State<PublicGoodsTutorial> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  List<int> chipsList =
      []; // = List<int>.of([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11,12,13,14,15,16,17,18,19,20]);
  bool showCoins = false;
  bool isDraggable = true;
  late RoundData roundData;

  String get timerString {
    Duration duration = Duration(seconds: widget.variables.time);
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    landscapeModeOnly();
    roundData = new RoundData(userTokens: widget.variables.maxTokens);
    for (int i = 0; i < 10 + 1; i++) {
      if (widget.variables.maxTokens > 10) {
        chipsList.add((i * (widget.variables.maxTokens / 10)).toInt());
      } else
        chipsList.add(i);
    }
    super.initState();
  }

  bool showRoundPoints = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = Resize.getHeight(context);
    double fontsize = screenHeight / 20;
    // print("HEight:" + screenHeight.toString());
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: (){
      //    setState(() {
      //      showRoundPoints = true;//!myBool;
      //  });
      // }),
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
                            // Image.asset(
                            //   'assets/images/clock.png',
                            //   scale: 850 / screenHeight,
                            // ),
                            Clock(animation: 'Stop'),
                            Text(
                              timerString,
                              style: TextStyle(fontSize: fontsize),
                            )
                            // TimerCount(time:widget.variables.time,animationEnds:null, start: false,),
                          ],
                        ),
                        Observer(builder: (_) {
                          return Panel(
                            fontsize,
                            title: AppLocalizations.of(context)
                                .translate('wallet'),
                            label: Text(roundData.wallet.toString(),
                                style: TextStyle(fontSize: fontsize)),
                          );
                        }),
                        Observer(builder: (_) {
                          return Panel(
                            fontsize,
                            title:
                                AppLocalizations.of(context).translate('chips'),
                            label: Text(roundData.userTokens.toString(),
                                style: TextStyle(fontSize: fontsize)),
                          );
                        }),
                        if (widget.variables.showRounds)
                          Text(
                            AppLocalizations.of(context).translate('round') +
                                ": " +
                                roundData.round.toString(),
                            style: TextStyle(fontSize: fontsize),
                          )
                      ],
                    ),
                  ), //),

                  CircleList(
                    rotateMode: RotateMode.onlyChildrenRotate,
                    origin: Offset(0, 0),
                    outerRadius: Resize.getHeight(context) * 0.5,
                    centerWidget:
                        //Imagem do Cofrinho
                        DragTarget<int>(
                      onAccept: (widget.function == null)
                          ? null
                          : (value) {
                              setState(() {
                                widget.function!();
                                isDraggable = false;
                                roundData.investment = value;
                                roundData.positionToken =
                                    chipsList.indexOf(value);
                                //startTiming=false;
                                //animateClock='Stop';
                                roundData.userTokens -= value;
                                showCoins = true;
                                roundData.wallet = roundData.wallet;
                                roundData.generateRound(widget.variables);
                                // print(roundData.rib);
                                cardKey.currentState!.toggleCard();
                              });
                            },
                      builder: (context, candidates, rejects) {
                        return Observer(builder: (_) {
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
                                      child: Text(
                                roundData.earning.toString(),
                                style: TextStyle(fontSize: fontsize * 2),
                              ))));
                        });
                      },
                    ),
                    children: List.generate(chipsList.length, (index) {
                      return GameToken(
                        round: 1,
                        value: (index >= 8)
                            ? chipsList[index - 8]
                            : chipsList[index + 3],
                        maxValue: widget.variables.maxTokens,
                        isDraggable:
                            (isDraggable && !widget.tutorialDistElection),
                        list: chipsList,
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
                          )),
                      if (widget.tutorialDistElection)
                        Padding(
                            padding: EdgeInsets.only(right: 5, top: 30),
                            child: Panel(
                              fontsize,
                              title: AppLocalizations.of(context)
                                  .translate('yourVotes'),
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
