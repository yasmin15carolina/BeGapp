import 'package:circle_list/circle_list.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';

import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/public_goods/widgets/token.dart';
import 'package:teoria_dos_jogos/widgets/clock.dart';
import 'package:teoria_dos_jogos/widgets/panel.dart';

class PublicGoodsCircle extends StatefulWidget {
  final PublicGoodsVariables variables;
  PublicGoodsCircle(this.variables);
  @override
  _PublicGoodsCircleState createState() => _PublicGoodsCircleState();
}

class _PublicGoodsCircleState extends State<PublicGoodsCircle> {
  // User user = new User(chips: 10,wallet: 0);
  //RoundData roundData = new RoundData();
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  List<int> chipsList = []; //List<int>.of([0,1,2,3,4,5,6,7,8,9,10]);
  bool showCoins = false;
  bool isDraggable = true;
  String get timerString {
    Duration duration = Duration(seconds: widget.variables.time);
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
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
                            Clock(animation: 'Stop'),
                            Text(
                              timerString,
                              style: TextStyle(fontSize: fontsize),
                            )
                            //TimerCount(time:10,animationEnds:game.timeOut, start: game.startTiming,),
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
                                ": 1",
                            style: TextStyle(fontSize: fontsize),
                          )
                      ],
                    ),
                  ), //),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.blue[900]!, width: screenHeight * 0.01),
                      color: Colors.blue[50],
                    ),
                    child: CircleList(
                      innerCircleColor: Colors.white,
                      rotateMode: RotateMode.stopRotate,
                      origin: Offset(0, 0),
                      outerRadius: Resize.getHeight(context) * 0.5,
                      centerWidget:
                          //Imagem do Cofrinho
                          DragTarget<int>(
                        onAccept: (value) {},
                        builder: (context, candidates, rejects) {
                          return FlipCard(
                              flipOnTouch: false,
                              direction: FlipDirection.HORIZONTAL,
                              key: cardKey,
                              front: Center(
                                  child: Container(
                                      height: screenHeight,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.blue[900]!,
                                            width: screenHeight * 0.01),
                                      ),
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
