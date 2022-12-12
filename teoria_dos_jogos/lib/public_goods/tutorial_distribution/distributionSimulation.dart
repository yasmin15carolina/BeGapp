import 'dart:math';

import 'package:circle_list/circle_list.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
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

class DistributionSimulation extends StatefulWidget {
  final User user;
  final PublicGoodsVariables variables;
  final Function next;
  DistributionSimulation(this.user, this.variables, this.next);
  @override
  _DistributionSimulationState createState() => _DistributionSimulationState();
}

class _DistributionSimulationState extends State<DistributionSimulation> {
  bool start = true;
  late Game game;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    game = new Game(
        widget.user,
        widget.variables,
        RoundData(
            electionId:
                Random().nextInt(widget.variables.notRealPlayers + 1) + 1,
            userTokens: widget.variables.maxTokens),
        RunningNumbers(false, true, widget.variables.maxTokens, 0, 1),
        RunningNumbers(false, false, 0, 0, 2));
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
    //portraitModeOnly();
    // game.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    game.pulseTheClock();
    game.context = context;

    double fontsize = screenHeight / 20;

    return Scaffold(
        body: WillPopScope(
      onWillPop: () async => game.onDispose(),
      child: Container(
          // margin: EdgeInsets.all(screenHeight/85.5),
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
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
                        title: AppLocalizations.of(context).translate('wallet'),
                        label: SizedBox()),

                    Panel(fontsize,
                        title: AppLocalizations.of(context).translate('chips'),
                        label: Text(
                          "0",
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
                ), //),

                CircleList(
                  rotateMode: RotateMode.stopRotate,
                  origin: Offset(0, 0),
                  centerWidget:
                      //Imagem do Cofrinho
                      DragTarget<int>(
                    onAccept: game.startTiming
                        ? game.onDragToken
                        : (value) {
                            // print("valor" + value.toString());
                          },
                    builder: (context, candidates, rejects) {
                      return Image.asset(
                        "assets/images/coinsBag.png",
                        scale: MediaQuery.of(context).size.height / 90,
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
                        isDraggable: false,
                        list: list,
                      );
                    });
                  }),
                ),
                Column(
                  children: [
                    Observer(builder: (_) {
                      return Padding(
                          padding: EdgeInsets.only(right: 5, top: 10),
                          child: Panel(
                            fontsize,
                            title: AppLocalizations.of(context)
                                .translate('didntPlayYet'),
                            label:
                                Text("0", style: TextStyle(fontSize: fontsize)),
                          ));
                    }),
                    if (game.roundData.distribution)
                      Padding(
                          padding: EdgeInsets.only(right: 5, top: 30),
                          child: Panel(
                            fontsize,
                            title: AppLocalizations.of(context)
                                .translate('yourVotes'),
                            label: Text(game.roundData.votes.toString(),
                                style: TextStyle(fontSize: fontsize)),
                          ))
                  ],
                )
              ],
            ),

            // Observer(builder: (_){
            //   return  game.coinsAnimation=="pigToWallet"?
            Container(
                //color:Colors.red.withOpacity(0.5),
                margin: EdgeInsets.only(
                    left: screenHeight * 0.1, top: screenHeight * 0.1),
                height: screenHeight * 0.3 * 2,
                width: screenHeight,
                //color: Colors.green.withOpacity(0.5),
                child: FlareActor(
                  'assets/flare/Coins.flr',
                  alignment: Alignment.center,
                  animation: 'Collect',
                  fit: BoxFit.contain,
                  callback: (String name) => game.coinsEnd(),
                  controller: game.flareControls,
                )),
            //     :SizedBox(height: 0,);
            // },),
            // Observer(builder: (_) {
            //   if(game.roundData.suspended)
            //   return
            //     Container(color:Colors.white.withOpacity(0.5));
            //   else return SizedBox(height: 0,);
            // }),
          ])),
    ));
  }
}
