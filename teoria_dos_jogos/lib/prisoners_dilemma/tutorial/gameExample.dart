import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/classes/rotation.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/classes/dilemmaVariables.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/widgets/animatedCard.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/widgets/dilemmaCard.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/widgets/draggableCard.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/widgets/resultsMatrix.dart';
import 'package:teoria_dos_jogos/widgets/clock.dart';
import 'package:teoria_dos_jogos/widgets/panel.dart';
import 'package:teoria_dos_jogos/widgets/timer.dart';

import 'dilemma_tutorial_store.dart';

class DilemmaGameTutorial extends StatefulWidget {
  final DilemmaVariables variables;
  final String txtOtherChoice;
  final String txtYourChoice;
  final bool draggable;
  final Function next;
  DilemmaGameTutorial(
    this.variables,
    this.txtYourChoice,
    this.txtOtherChoice,
    this.draggable,
    this.next,
  );
  @override
  _DilemmaGameTutorialState createState() => _DilemmaGameTutorialState();
}

class _DilemmaGameTutorialState extends State<DilemmaGameTutorial> {
  PrisonerDilemmaTutorial game = new PrisonerDilemmaTutorial();
  bool hideVariables = true;
  @override
  void initState() {
    landscapeModeOnly();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();

    game.variables = widget.variables;
    game.yourChoiceTarget = DilemmaCard(
      borderColor: Colors.black,
      txt: widget.txtYourChoice,
      fontScale: 0.35,
    );
    game.otherChoiceTarget = DilemmaCard(
        borderColor: Colors.black, txt: widget.txtOtherChoice, fontScale: 0.35);
    game.yourTxt = widget.txtYourChoice;
    game.otherTxt = widget.txtOtherChoice;
    game.dilemmaRound.oponentChoice = 0;
    game.next = widget.next;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    double p = 0.4;
    double width = Resize.getWidth(context);
    double height = Resize.getHeight(context);
    game.context = context;
    double fontsize = height / 20;
    return Scaffold(
        // backgroundColor: Colors.blueGrey[200],
        body: Stack(children: [
      Container(
          padding: EdgeInsets.only(left: width * 0.01),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 2,
                child: Observer(builder: (_) {
                  return Opacity(
                    opacity: game.dilemmaRound.result == "" ? 1 : 0.3,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Observer(builder: (_) {
                            return Container(
                              //color: Colors.purple,
                              margin: EdgeInsets.only(right: width * 0.115),
                              alignment: Alignment.centerLeft,
                              child: Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Clock
                                    Expanded(
                                      flex: 2,
                                      child: Opacity(
                                          opacity: (game.variables!.showClock &&
                                                  !hideVariables)
                                              ? 1
                                              : 0,
                                          child: Column(
                                            children: <Widget>[
                                              Clock(
                                                animation:
                                                    "Stop", //game.animateClock,
                                                scale: 0.7,
                                              ),
                                              TimerCount(
                                                time: game.variables!.maxTime,
                                                animationEnds: game.timeOut,
                                                start:
                                                    false, //game.startTiming,
                                              ),
                                            ],
                                          )),
                                    ),

                                    Expanded(
                                      flex: 3,
                                      child: Opacity(
                                          opacity:
                                              (game.variables!.showYourPoints &&
                                                      !hideVariables)
                                                  ? 1
                                                  : 0,
                                          child: Panel(fontsize,
                                              title:
                                                  AppLocalizations.of(context)
                                                      .translate('you'),
                                              label: GestureDetector(
                                                onTap: game.toggleYourPoints,
                                                child: Text(
                                                  game.dilemmaRound
                                                          .seeYourPoints
                                                      ? game.dilemmaRound
                                                          .userPoints
                                                          .toString()
                                                      : AppLocalizations.of(
                                                              context)
                                                          .translate('see'),
                                                  style: TextStyle(
                                                    fontSize: fontsize,
                                                    decoration: game
                                                            .dilemmaRound
                                                            .seeYourPoints
                                                        ? TextDecoration.none
                                                        : TextDecoration
                                                            .underline,
                                                  ),
                                                ),
                                              ))),
                                    ),

                                    Expanded(
                                      flex: 3,
                                      child: Opacity(
                                        opacity: (game.variables!
                                                    .showOtherPoints &&
                                                game.dilemmaRound.otherRand &&
                                                !hideVariables)
                                            ? 1
                                            : 0,
                                        child: GestureDetector(
                                            onTap: game.dilemmaRound.otherRand
                                                ? game.toggleOtherPoints
                                                : () {},
                                            child: Panel(
                                              fontsize,
                                              title:
                                                  AppLocalizations.of(context)
                                                      .translate('other'),
                                              label: Text(
                                                game.dilemmaRound.seeOtherPoints
                                                    ? game.dilemmaRound
                                                        .oponentPoints
                                                        .toString()
                                                    : AppLocalizations.of(
                                                            context)
                                                        .translate('see'),
                                                style: TextStyle(
                                                  fontSize: fontsize,
                                                  decoration: game.dilemmaRound
                                                          .seeOtherPoints
                                                      ? TextDecoration.none
                                                      : TextDecoration
                                                          .underline,
                                                ),
                                              ),
                                            )),
                                      ),
                                    )
                                  ]),
                            );
                          }),
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: width * 0.11),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DragTarget<int>(
                                    onAccept: game.onDragCard,
                                    builder: (context, candidates, rejects) {
                                      return Observer(builder: (_) {
                                        return game.yourChoiceTarget;
                                      });
                                    }),
                                Opacity(
                                    opacity: (game.variables!.showRounds &&
                                            !hideVariables)
                                        ? 1
                                        : 0,
                                    child: Panel(
                                      fontsize,
                                      title: AppLocalizations.of(context)
                                          .translate('round'),
                                      label: Text(
                                        game.dilemmaRound.round.toString(),
                                        style: TextStyle(fontSize: fontsize),
                                      ),
                                    )),
                                // game.yourChoiceTarget,
                                Observer(builder: (_) {
                                  return game.otherChoiceTarget;
                                }),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: Column(children: [
                                      Container(
                                        padding: EdgeInsets.all(width * 0.01),
                                        decoration: BoxDecoration(
                                          //color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.blueAccent,
                                              width: 2),
                                        ),
                                        child: Observer(builder: (_) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ((game.userChoice == 0 ||
                                                          game.userChoice ==
                                                              -1) &&
                                                      widget.draggable &&
                                                      (game.dilemmaRound
                                                                  .round ==
                                                              1 ||
                                                          game.dilemmaRound
                                                                  .round ==
                                                              4))
                                                  ? DraggableCard(Colors.red,
                                                      game.draggable)
                                                  : DilemmaCard(
                                                      color: Colors.red),
                                              ((game.userChoice == 1 ||
                                                          game.userChoice ==
                                                              -1) &&
                                                      widget.draggable &&
                                                      (game.dilemmaRound
                                                                  .round ==
                                                              2 ||
                                                          game.dilemmaRound
                                                                  .round ==
                                                              3))
                                                  ? DraggableCard(Colors.black,
                                                      game.draggable)
                                                  : DilemmaCard(
                                                      color: Colors.black),
                                            ],
                                          );
                                        }),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('yourCards'),
                                        style:
                                            TextStyle(fontSize: fontsize * 0.7),
                                      ),
                                    ]),
                                  ),
                                  SizedBox(
                                    width: width * 0.01,
                                  ),
                                  Expanded(
                                      child: Column(children: [
                                    Container(
                                        padding: EdgeInsets.all(width * 0.01),
                                        decoration: BoxDecoration(
                                          //color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.blueAccent,
                                              width: 2),
                                        ),
                                        child: Observer(builder: (_) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              game.oponentChoice == 0
                                                  ? AnimatedCard(
                                                      Colors.red,
                                                      () => game
                                                          .onEndCardAnimation(
                                                              Colors.red),
                                                      Offset(width * 0.078,
                                                          -height * 0.318))
                                                  : DilemmaCard(
                                                      color: Colors.red),
                                              game.oponentChoice == 1
                                                  ? AnimatedCard(
                                                      Colors.black,
                                                      () => game
                                                          .onEndCardAnimation(
                                                              Colors.black),
                                                      Offset(-width * 0.05,
                                                          -height * 0.318))
                                                  : DilemmaCard(
                                                      color: Colors.black)
                                            ],
                                          );
                                        })),
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate('otherCards'),
                                      style:
                                          TextStyle(fontSize: fontsize * 0.7),
                                    ),
                                  ]))
                                ],
                              )),
                            ],
                          ),
                        ]),
                  );
                }),
              ),

              //MATRIZ DAS POSSIBILIDADES
              Expanded(
                  flex: 1,
                  child: Observer(builder: (_) {
                    return ResultsMatrix(
                        p, game.dilemmaRound.result, false, widget.variables);
                  }))
            ],
          )),
    ]));
  }
}
// class Coordenates{
//   double x;
//   double
// }
