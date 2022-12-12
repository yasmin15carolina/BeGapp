import 'dart:math';

import 'package:circle_list/circle_list.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/popup_message_pg.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/classes/time_taken_tutorial_pg.dart';
import 'package:teoria_dos_jogos/classes/user.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';
import 'package:teoria_dos_jogos/public_goods/store/game_store.dart';
import 'package:teoria_dos_jogos/public_goods/store/round_data_store.dart';
import 'package:teoria_dos_jogos/public_goods/store/runningNumbers.dart';
import 'package:teoria_dos_jogos/public_goods/widgets/token.dart';
import 'package:teoria_dos_jogos/widgets/clock.dart';
import 'package:teoria_dos_jogos/widgets/panel.dart';
import 'package:teoria_dos_jogos/public_goods/widgets/panelFade.dart';
import 'package:teoria_dos_jogos/public_goods/widgets/CountNumbers.dart';
import 'package:teoria_dos_jogos/widgets/timer.dart';
import 'package:teoria_dos_jogos/classes/rotation.dart';

class PublicGoodsGamePage extends StatefulWidget {
  final User user;
  final PublicGoodsVariables variables;
  final PGTimeTutorial timeTutorial;
  final List<PopUpMessagePublicGoods> messages;
  PublicGoodsGamePage(
      this.user, this.variables, this.timeTutorial, this.messages);
  @override
  _PublicGoodsGamePageState createState() => _PublicGoodsGamePageState();
}

class _PublicGoodsGamePageState extends State<PublicGoodsGamePage> {
  bool start = true;
  late Game game;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    game = new Game(
        widget.user,
        widget.variables,
        RoundData(
            electionId: Random().nextInt(widget.variables.notRealPlayers + 1),
            userTokens: widget.variables.maxTokens),
        RunningNumbers(false, true, widget.variables.maxTokens, 0, 1),
        RunningNumbers(false, false, 0, 0, 2),
        timeTutorial: widget.timeTutorial,
        messages: widget.messages);
    for (int i = 0; i < 10 + 1; i++) {
      if (widget.variables.maxTokens > 10) {
        game.tokensList.add((i * (game.variables.maxTokens / 10)).toInt());
      } else
        game.tokensList.add(i);
    }
    game.messages!.forEach((element) {
      game.messagesShown.add(false);
    });
    game.callPlayersDelay();
    game.blinkPanel();
    game.roundData.votes = game.variables.notRealPlayers;
    // game.roundData.votesScreen = game.variables.notRealPlayers;
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
    print("${widget.user.id} USER");
    double screenHeight = Resize.getHeight(context);
    double screenWidth = Resize.getWidth(context);
    game.pulseTheClock();
    game.context = context;
    // game.showGraphic(endMessage :AppLocalizations.of(context).translate('PGEndGameLost'));
    double fontsize = screenHeight / 20;
    // game.rounds.forEach((element) {
    //   // if(element.distribution && element.earning>-1 && element.investment!=null )
    //   // print(((element.earning/element.rib)*100).toInt().toString()+"  "+element.electionCount.toString()+"  "+element.distributionStable.toString());
    //   element.printData();
    // });
    return Scaffold(
        // floatingActionButton: FloatingActionButton(onPressed: () {

        //   //game.nextLevel();
        //   //game.showGraphic(endMessage:AppLocalizations.of(context).translate('PGEndGameLost'));
        //   // print(game.timeTutorial.distribution);
        //   // print(game.roundData.timeRound.dragToken);
        // }),
        body: WillPopScope(
      onWillPop: () async => game.onDispose(),
      child: Center(
        child: Container(
            // margin: EdgeInsets.all(screenHeight/85.5),
            height: screenHeight,
            width: screenWidth,
            child: Stack(children: [
              Observer(builder: (_) {
                return Flex(
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
                              Clock(animation: game.animateClock),
                              TimerCount(
                                time: game.variables.time,
                                animationEnds: game.timeOut,
                                start: game.startTiming,
                                getTime: game.roundData.timeRound.setDragToken,
                              ),
                            ],
                          ),
                          Panel(
                            fontsize,
                            title: AppLocalizations.of(context)
                                .translate('wallet'),
                            label: game.walletCount.start
                                ? Count(
                                    animationEnds: () => game.endRunningNumbers(
                                        game.walletCount.stop),
                                    start: game.walletCount.start,
                                    down: game.walletCount.down,
                                    inicial: game.walletCount.inicial,
                                    diference: game.walletCount.diference,
                                    factor: game.walletCount.factor,
                                  )
                                : Text(game.roundData.wallet.toString(),
                                    style: TextStyle(fontSize: fontsize)),
                          ),

                          PanelFade(
                              Panel(fontsize,
                                  title: AppLocalizations.of(context)
                                      .translate('chips'),
                                  label: game.tokensCount.start
                                      ? Count(
                                          animationEnds: game.tokensCount.stop,
                                          start: game.tokensCount.start,
                                          down: game.tokensCount.down,
                                          inicial: game.tokensCount.inicial,
                                          diference: game.tokensCount.diference,
                                          factor: game.tokensCount.factor,
                                        )
                                      : Text(
                                          game.roundData.userTokens.toString(),
                                          style:
                                              TextStyle(fontSize: fontsize))),
                              game.showPanelTokens),
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
                      outerRadius: screenHeight * 0.5,
                      centerWidget:
                          //Imagem do Cofrinho
                          DragTarget<int>(
                        onAccept: game.startTiming
                            ? game.onDragToken
                            : (value) {
                                print("valor" + value.toString());
                              },
                        builder: (context, candidates, rejects) {
                          return FlipCard(
                              flipOnTouch: false,
                              direction: FlipDirection.HORIZONTAL,
                              key: game.cardKey,
                              front: Center(
                                  child: Container(
                                      child: Image.asset(
                                "assets/images/moneyPig.png",
                                scale: 411 / screenHeight,
                              ))),
                              back: Observer(builder: (_) {
                                return Container(
                                    child: Center(
                                        child: game.pigCount.start
                                            ? Count(
                                                animationEnds:
                                                    game.endCountEarningTokens,
                                                start: game.pigCount.start,
                                                down: game.pigCount.down,
                                                inicial: game.pigCount.inicial,
                                                diference:
                                                    game.pigCount.diference,
                                                factor: game.pigCount.factor,
                                                fontsize: fontsize * 2,
                                              )
                                            : Text(
                                                (game.roundData.earning > -1)
                                                    ?
                                                    // (game.roundData.earning+game.variables.maxTokens-game.roundData.investment).toString():
                                                    //game.roundData.earning.toString():
                                                    game.roundData.roundPoints
                                                        .toString()
                                                    : (game.roundData.suspended)
                                                        ? game.roundData
                                                            .playersEarning![0]
                                                            .toString()
                                                        : "0",
                                                style: TextStyle(
                                                    fontSize: fontsize * 2),
                                              )));
                              }));
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
                            isDraggable: game.startTiming,
                            list: list,
                          );
                        });
                      }),
                    ),
                    Expanded(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Observer(builder: (_) {
                            return Padding(
                                padding: EdgeInsets.only(right: 5, top: 10),
                                child: Panel(
                                  fontsize,
                                  title: AppLocalizations.of(context)
                                      .translate('didntPlayYet'),
                                  label: Text(
                                      game.roundData.playersPlay.toString(),
                                      style: TextStyle(fontSize: fontsize)),
                                ));
                          }),
                          //  if(game.roundData.electionCount>0)
                          if (game.roundData.votesScreen > 0)
                            Padding(
                                padding: EdgeInsets.only(right: 5, top: 30),
                                child: Panel(
                                  fontsize,
                                  title: AppLocalizations.of(context)
                                      .translate('yourVotes'),
                                  label: Text(
                                      game.roundData.votesScreen.toString(),
                                      style: TextStyle(fontSize: fontsize)),
                                ))
                        ],
                      ),
                    )
                  ],
                );
              }),
              Observer(
                builder: (_) {
                  return game.coinsAnimation == "tokensToPig"
                      ? Container(
                          //tokensToPig
                          // color:Colors.red.withOpacity(0.5),
                          alignment: Alignment.bottomLeft,
                          child: Transform(
                            // Transform widget
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001) // perspective
                              ..rotateZ(-60),
                            alignment: FractionalOffset.center,
                            child: Container(
                                height: screenHeight * 0.3 * 2,
                                width: screenHeight,
                                // color: Colors.green.withOpacity(0.5),
                                child: FlareActor(
                                  "assets/flare/Coins.flr",
                                  alignment: Alignment.center,
                                  animation: 'Collect',
                                  fit: BoxFit.contain,
                                  callback: (String name) =>
                                      game.coinsEnd(name),
                                  controller: game.flareControls,
                                )),
                          ))
                      : SizedBox(
                          height: 0,
                        );
                },
              ),
              Observer(
                builder: (_) {
                  return game.coinsAnimation == "pigToWallet"
                      ? Container(
                          // color:Colors.red.withOpacity(0.5),
                          margin: EdgeInsets.only(
                              left: screenHeight * 0.1,
                              top: screenHeight * 0.1),
                          height: screenHeight * 0.3 * 2,
                          width: screenHeight,
                          //color: Colors.green.withOpacity(0.5),
                          child: FlareActor(
                            'assets/flare/Coins.flr',
                            alignment: Alignment.center,
                            animation: 'Collect',
                            fit: BoxFit.contain,
                            callback: (String name) => game.coinsEnd(name),
                            controller: game.flareControls,
                          ))
                      : SizedBox(
                          height: 0,
                        );
                },
              ),
              Observer(builder: (_) {
                if (game.roundData.suspended)
                  return Container(color: Colors.white.withOpacity(0.5));
                else
                  return SizedBox(
                    height: 0,
                  );
              }),
            ])),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     showDialog(
      //       context: context,
      //       child: Dialog(
      //         child:
      //           Container(
      //             child: RaisedButton(
      //               onPressed: (){
      //             Navigator.pop(context);
      //             }
      //             ),
      //           ),
      //         )
      //     ).then((value) {
      //       change(context);
      //     }
      //     );
      //   }
      // ),
    ));
  }
}
