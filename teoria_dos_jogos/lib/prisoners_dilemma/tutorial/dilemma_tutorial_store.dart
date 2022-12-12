import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/soundEffects.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/classes/dilemmaVariables.dart';
import 'package:mobx/mobx.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/store/dilemmaround_store.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/widgets/dilemmaCard.dart';
import 'package:teoria_dos_jogos/widgets/nextAnimation.dart';
part 'dilemma_tutorial_store.g.dart';

class PrisonerDilemmaTutorial = _PrisonerDilemmaTutorialBase
    with _$PrisonerDilemmaTutorial;

abstract class _PrisonerDilemmaTutorialBase with Store {
  var context;
  DilemmaVariables? variables;
  String? yourTxt;
  String? otherTxt;
  bool lastToPlay = false;
  Function? next;

  @observable
  bool startTiming = true; //se o relogio rodando

  @observable
  String animateClock = 'Pulse'; //nome da animação do relogio

  @observable
  Widget yourChoiceTarget = DilemmaCard(
    borderColor: Colors.black,
  );

  @observable
  Widget otherChoiceTarget = DilemmaCard(
    borderColor: Colors.black,
  );

  @observable
  bool draggable = true;

  @observable
  int oponentChoice = -1;

  @observable
  int userChoice = -1;

  @observable
  DilemmaRound dilemmaRound = DilemmaRound();
  //Result result = new Result(0);

  List<DilemmaRound> listRounds = [];

  var userId;
  //tempo de resposta do outro jogador
  @observable
  int otherPlayerDelay = 0;
  //tempo de espera para desvirar a carta
  @observable
  int waitDelay = 10;

  @action
  toggleYourPoints() {
    dilemmaRound.seeYourPoints = true;
  }

  @action
  toggleOtherPoints() {
    dilemmaRound.seeOtherPoints = true;
  }

  @action
  onDragCard(value) {
    draggable = false;
    userChoice = value;
    Color _color = value == 0 ? Colors.red : Colors.black;
    yourChoiceTarget = DilemmaCard(
      color: _color,
    );
    startTiming = false;
    animateClock = "Stop";
    dilemmaRound.userChoice = value;
    computeChoice();
    next!();
  }

  @action
  computeChoice() async {
    Future.delayed(Duration(seconds: 5), () async {
      oponentChoice = dilemmaRound.oponentChoice!;
    });
  }

  @action
  showResult() {
    dilemmaRound.calculateResult(variables!);
    var r = new DilemmaRound(
        round: dilemmaRound.round,
        userChoice: dilemmaRound.userChoice,
        oponentChoice: dilemmaRound.oponentChoice,
        userPoints: dilemmaRound.userPoints,
        oponentPoints: dilemmaRound.oponentPoints,
        lostRound: dilemmaRound.lostRound,
        seeYourPoints: dilemmaRound.seeYourPoints,
        seeOtherPoints: dilemmaRound.seeOtherPoints);
    listRounds.add(r);
    //result.printaLista(listResults);
    Future.delayed(Duration(seconds: waitDelay), () async {
      if (dilemmaRound.round == 4)
        next!();
      else
        nextRound();
    });
  }

  @action
  nextRound() {
    dilemmaRound.result = "";
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => NextAnimation(-MediaQuery.of(context).size.width / 2,
                AppLocalizations.of(context).translate('nextRound'),
                onEndAnimation: () {
              Navigator.of(context).pop();
              if (variables!.algorithm == "tft") {
                dilemmaRound.oponentChoice = dilemmaRound.userChoice;
              }
              dilemmaRound.round++;
              dilemmaRound.seeYourPoints = false;
              dilemmaRound.seeOtherPoints = false;
              lastToPlay = false;
              draggable = true;
              oponentChoice = -1;
              userChoice = -1;
              yourChoiceTarget = DilemmaCard(
                borderColor: Colors.black,
                txt: yourTxt!,
                fontScale: 0.35,
              );
              otherChoiceTarget = DilemmaCard(
                borderColor: Colors.black,
                txt: otherTxt!,
                fontScale: 0.35,
              );
              startTiming = true;
              animateClock = "Pulse";
              if (dilemmaRound.round == 2)
                dilemmaRound.oponentChoice = 1;
              else if (dilemmaRound.round == 3)
                dilemmaRound.oponentChoice = 0;
              else if (dilemmaRound.round == 4) dilemmaRound.oponentChoice = 1;
              next!();
              if (dilemmaRound.round == variables!.roundsNumber) {
                showGraphic();
                sendDataToDatabase();
              }
            }));
  }

  @action
  timeOut() {
    dilemmaRound.lostRound = true;
    //ativa a animação do relogio
    animateClock = 'Shake';
    startTiming = false;
    //Toca o despertador
    SoundEffects.play('audio/ClockBell.mp3');
    Future.delayed(new Duration(seconds: 1, milliseconds: 50), () async {
      //pausa a animação do relogio
      animateClock = 'Stop';
      dilemmaRound.userChoice = 0;
      dilemmaRound.oponentChoice = 1;
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => NextAnimation(-MediaQuery.of(context).size.width / 2,
                  AppLocalizations.of(context).translate('lostRound'),
                  onEndAnimation: () {
                Navigator.of(context).pop();
                showResult();
              }));
    });
  }

  @action
  sendDataToDatabase() async {}

  @action
  showGraphic() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              //title: Text("Aviso!"),
              content: Text(
                AppLocalizations.of(context).translate('thanks'),
                style:
                    TextStyle(fontSize: MediaQuery.of(context).size.width / 25),
              ),
              actions: <Widget>[
                TextButton(
                    child: Text(
                      AppLocalizations.of(context).translate('seeResult'),
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 25),
                    ),
                    onPressed: () async {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context)=>
                      //     ResultPage(
                      //       user: user,
                      //       listResults: listRounds,
                      //       algorithm:variables.algorithm
                      //     )
                      //   )
                      // );
                    }),
              ],
            ));
  }

  @action
  onEndCardAnimation(Color color) {
    otherChoiceTarget = DilemmaCard(
        // color: Colors.transparent,
        );
    next!();
    showResult();
  }
}
