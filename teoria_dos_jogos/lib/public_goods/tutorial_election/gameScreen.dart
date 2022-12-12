import 'dart:math';

import 'package:circle_list/circle_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/classes/user.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';
import 'package:teoria_dos_jogos/public_goods/store/game_store.dart';
import 'package:teoria_dos_jogos/public_goods/store/round_data_store.dart';
import 'package:teoria_dos_jogos/public_goods/store/runningNumbers.dart';
import 'package:teoria_dos_jogos/public_goods/widgets/token.dart';
import 'package:teoria_dos_jogos/widgets/clock.dart';
import 'package:teoria_dos_jogos/widgets/panel.dart';
import 'package:teoria_dos_jogos/widgets/timer.dart';
import 'package:teoria_dos_jogos/classes/rotation.dart';

class GameScreen extends StatefulWidget {
  final PublicGoodsVariables variables;
  final Function next;
  final bool draggable;
  GameScreen(this.variables, this.next, this.draggable);
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool start = true;
  late Game game;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    game = new Game(
      new User(),
      widget.variables,
      RoundData(
          electionId: Random().nextInt(widget.variables.notRealPlayers + 1) + 1,
          userTokens: widget.variables.maxTokens),
      RunningNumbers(false, true, widget.variables.maxTokens, 0, 1),
      RunningNumbers(false, false, 0, 0, 2),
    );
    for (int i = 0; i < 10 + 1; i++) {
      if (widget.variables.maxTokens > 10) {
        game.tokensList.add((i * (game.variables.maxTokens / 10)).toInt());
      } else
        game.tokensList.add(i);
    }
    game.callPlayersDelay();
    game.blinkPanel();
    game.roundData.votes = game.variables.notRealPlayers;
    landscapeModeOnly();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = Resize.getHeight(context);
    game.pulseTheClock();
    game.context = context;

    double fontsize = screenHeight / 20;

    return Scaffold(
        body: WillPopScope(
      onWillPop: () async => game.onDispose(),
      child: Center(
        child: Container(
            // margin: EdgeInsets.all(screenHeight/85.5),
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
                            Clock(animation: "Stop"),
                            TimerCount(
                                time: game.variables.time,
                                animationEnds: () {}, //game.timeOut,
                                start: false //game.startTiming,
                                ),
                          ],
                        ),
                        Panel(fontsize,
                            title: AppLocalizations.of(context)
                                .translate('wallet'),
                            label: SizedBox()),

                        Panel(fontsize,
                            title:
                                AppLocalizations.of(context).translate('chips'),
                            label: Text(
                              "",
                              style: TextStyle(fontSize: fontsize),
                            )),
                        if (widget.variables.showRounds)
                          Text(
                            AppLocalizations.of(context).translate('round') +
                                ": " +
                                game.roundData.round.toString(),
                            style: TextStyle(fontSize: fontsize),
                          )
                      ],
                    ),
                  ), //),

                  CircleList(
                    rotateMode: RotateMode.stopRotate,
                    origin: Offset(0, 0),
                    outerRadius: Resize.getHeight(context) * 0.5,
                    centerWidget: DragTarget<int>(
                      onAccept: game.startTiming
                          ? game.onDragToken
                          : (value) {
                              // print("valor" + value.toString());
                            },
                      builder: (context, candidates, rejects) {
                        return (widget.draggable)
                            ? Image.asset(
                                "assets/images/moneyPig.png",
                                scale: 411 / screenHeight,
                              )
                            : Image.asset(
                                "assets/images/coinsBag.png",
                                scale: screenHeight / 90,
                              );
                      },
                    ),
                    children: List.generate(11, (index) {
                      List<int> list = game.tokensList.toList();
                      list.sort();
                      return Observer(builder: (_) {
                        return new GameToken(
                          round: game.roundData.round,
                          value: (index >= 8)
                              ? game.tokensList[index - 8]
                              : game.tokensList[index + 3],
                          maxValue: game.variables.maxTokens,
                          isDraggable: widget.draggable,
                          list: list,
                        );
                      });
                    }),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(right: 5, top: 10),
                            child: Panel(
                              fontsize,
                              title: AppLocalizations.of(context)
                                  .translate('didntPlayYet'),
                              label: Text("",
                                  style: TextStyle(fontSize: fontsize)),
                            )),
                        if ((widget.draggable))
                          Padding(
                              padding: EdgeInsets.only(right: 5, top: 30),
                              child: Panel(
                                fontsize,
                                title: AppLocalizations.of(context)
                                    .translate('yourVotes'),
                                label:
                                    Text("", //ame.roundData.votes.toString(),
                                        style: TextStyle(fontSize: fontsize)),
                              ))
                      ],
                    ),
                  )
                ],
              ),
            ])),
      ),
    ));
  }
}
