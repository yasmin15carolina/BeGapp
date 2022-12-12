import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/Database.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/classes/soundEffects.dart';
import 'package:teoria_dos_jogos/classes/time_taken_tutorial_pd.dart';
import 'package:teoria_dos_jogos/classes/user.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/classes/dilemmaVariables.dart';
import 'package:mobx/mobx.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/classes/popup_message_pd.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/store/dilemmaround_store.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/widgets/dilemmaCard.dart';
import 'package:teoria_dos_jogos/public_goods/pages/messagePage.dart';
import 'package:teoria_dos_jogos/widgets/nextAnimation.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../pages/welcome.page.dart';
part 'prisoner_dilemma_game_store.g.dart';

class PrisonerDilemmaGame = _PrisonerDilemmaGameBase with _$PrisonerDilemmaGame;

abstract class _PrisonerDilemmaGameBase with Store {
  User user = new User();
  var context;
  DilemmaVariables? variables;
  PDTimeTutorial timeTutorial = new PDTimeTutorial();
  String? yourTxt;
  String? otherTxt;
  bool lastToPlay = false;
  bool endGame = false;
  bool db = true;
  String? currentlyAlgorithm;
  List<PopUpMessagePrisonersDilemma>? messages;
  List<bool> messagesShown = []; //controlar as mensagens que já foram exibidas

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

  List<DilemmaRound> listRounds = [];
  var userId;

  //tempo de resposta do outro jogador
  @observable
  int otherPlayerDelay = 0;
  //tempo de espera para desvirar a carta
  @observable
  int waitDelay = 5;

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
    if (lastToPlay) executeAlgorithm();
  }

  @action
  executeAlgorithm() async {
    switch (currentlyAlgorithm) {
      case "Tit For Tat":
        if (dilemmaRound.round == 1)
          dilemmaRound.oponentChoice = 0; //coopera
        else
          dilemmaRound.oponentChoice = listRounds.last.userChoice;
        break;
      case "Suspicious Tit For Tat":
        if (dilemmaRound.round == 1)
          dilemmaRound.oponentChoice = 1; //delata
        else
          dilemmaRound.oponentChoice = listRounds.last.userChoice;
        break;
      case "Tit For Two Tats": //se delatou nas duas ultimas, oponente delata, se não, coopera
        if (listRounds.length > 2) {
          //checa se deletou nas duas ultimas, não precisa verificar se perdeu a vez pq quando perde coopera automaticamente
          if (listRounds.last.oponentChoice == 1 &&
              listRounds[listRounds.length - 2].oponentChoice == 1)
            dilemmaRound.oponentChoice = 1;
        } else
          dilemmaRound.oponentChoice = 0;
        break;
      case "Pavlov":
        if (dilemmaRound.round == 1)
          dilemmaRound.oponentChoice = 0;
        else if (listRounds.last.userChoice != dilemmaRound.userChoice) {
          //shift
          dilemmaRound.oponentChoice = dilemmaRound.oponentChoice == 0 ? 1 : 0;
        }
        break;
      case "Probabilities":
        if (dilemmaRound.round == 1)
          dilemmaRound.oponentChoice = Random().nextInt(2);
        else {
          List<DilemmaRound> list = listRounds;
          list.removeWhere((e) => e.lostRound);
          int p = 0;
          int i = list.length - 1;
          while (list.length >= 1 && i >= 0 && p < 100) {
            if (list[i].userChoice == list.last.userChoice)
              p += 25;
            else
              i = -1;
            i--;
          }
          int rand = Random().nextInt(100);
          if (rand < p)
            dilemmaRound.oponentChoice = list.last
                .userChoice; //probabilidade de acordo com as ultimas escolhas
          else
            dilemmaRound.oponentChoice = list.last.userChoice == 0 ? 1 : 0;
        }
        break;
      case "Cooperate":
        dilemmaRound.oponentChoice = 0;
        break;
      case "Defect":
        dilemmaRound.oponentChoice = 1;
        break;
      case "Random":
        var rand = new Random();
        dilemmaRound.oponentChoice = rand.nextInt(2);
        break;
    }
    oponentChoice = dilemmaRound.oponentChoice!;
  }

  @action
  callPlayersDelay() {
    otherPlayerDelay = new Random().nextInt(variables!.maxTime);
    dilemmaRound.yourRand =
        variables!.yourPointsRand ? new Random().nextBool() : true;
    dilemmaRound.otherRand =
        variables!.otherPointsRand ? new Random().nextBool() : true;
    Future.delayed(Duration(seconds: otherPlayerDelay), () async {
      if (userChoice == -1)
        lastToPlay = true;
      else
        executeAlgorithm();
    });
  }

  @action
  checkStability() {
    if (variables!.stable == 0) return; //sem criterio de estabilidade
    if (listRounds.length < variables!.stable) return;
    List<DilemmaRound> list = listRounds;
    list.removeWhere((e) => e.lostRound);
    if (list.length < variables!.stable) return;
    list = list.sublist(list.length - variables!.stable, list.length);
    if (list.first.stableCount != list.last.stableCount) return;

    int index = list.length - variables!.stable;
    int n = 0;
    bool lost = false;
    for (int i = index; i < list.length; i++) {
      if (list[i].lostRound) {
        lost = true;
      } else
        n += list[i].userChoice!;
    }
    if (!lost && (n == 0 || n == variables!.stable)) {
      dilemmaRound.stableCount++;
      startTiming = false;
      if (dilemmaRound.stableCount == 2) endGame = true;
      // endGame=true;
      currentlyAlgorithm = variables!.secondAlgorithm;
    }
  }

  @action
  showResult() {
    dilemmaRound.calculateResult(variables!);
    DilemmaRound r = registerRound();
    Future.delayed(Duration(seconds: waitDelay), () async {
      dilemmaRound.result = "";
      if (endGame)
        showGraphic();
      else
        checkShowMsg(r);
      // nextRound();
    });
  }

  checkShowMsg(DilemmaRound rd) {
    if (messages!.isNotEmpty) {
      bool showMessage = false;
      int index = -1;
      for (var i = 0; i < messages!.length; i++) {
        if (messages![i].round == dilemmaRound.round && !messagesShown[i]) {
          showMessage = true;
          index = i;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MessagePage(
                  message: messages![i].message,
                  next: () => checkShowMsg(rd))));
          break;
        }
      }

      if (index > -1) messagesShown[index] = true;
      // if (index > -1) messages.removeAt(index);
      if (!showMessage)
        nextRound(); //se não exibiu nenhuma mensagem, segue para prox rodada
    } else
      nextRound();
  }

  @action
  registerRound() {
    var r = new DilemmaRound(
        round: dilemmaRound.round,
        userChoice: dilemmaRound.userChoice,
        oponentChoice: dilemmaRound.oponentChoice,
        userPoints: dilemmaRound.userPoints,
        oponentPoints: dilemmaRound.oponentPoints,
        lostRound: dilemmaRound.lostRound,
        seeYourPoints: dilemmaRound.seeYourPoints,
        seeOtherPoints: dilemmaRound.seeOtherPoints,
        stableCount: dilemmaRound.stableCount);
    listRounds.add(r);
    checkStability();
    //result.printaLista(listResults);
    sendDataToDatabase();
    return r;
  }

  @action
  nextRound() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => NextAnimation(-MediaQuery.of(context).size.width / 2,
                AppLocalizations.of(context).translate('nextRound'),
                onEndAnimation: () {
              Navigator.of(context).pop();

              dilemmaRound.round++;
              dilemmaRound.lostRound = false;
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
              // if(dilemmaRound.round == 5){
              if (dilemmaRound.round == variables!.roundsNumber) {
                showGraphic();
                startTiming = false;
                sendDataToDatabase();
              } else
                callPlayersDelay();
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
  sendDataToDatabase() async {
    try {
      bool connected = UniversalPlatform.isWeb ? true : false;
      if (!UniversalPlatform.isWeb) {
        final result = await InternetAddress.lookup('google.com');
        connected = (result.isNotEmpty && result[0].rawAddress.isNotEmpty);
      }
      if (connected) {
        print('connected');
        if (db) {
          //armazena os dados
          DilemmaRound dr = dilemmaRound;
          int sawYourPoints = dr.seeYourPoints ? 1 : 0;
          int sawOtherPoints = dr.seeOtherPoints ? 1 : 0;
          int lostRound = dr.lostRound ? 1 : 0;
          String query =
              "INSERT INTO `dilemma_rounds` (`userId`, `round`, `computer`, `userChoice`,  `otherPoints`, `userPoints`, `lostRound`, `sawOtherPoints`, `sawYourPoints`)" +
                  " VALUES('${user.id}','${dr.round}','${dr.oponentChoice}','${dr.userChoice}','${dr.oponentPoints}','${dr.userPoints}','$lostRound','$sawOtherPoints','$sawYourPoints')";
          Database.insert(query);
          query =
              "INSERT INTO `time_taken_round_pd`(`drag_card`, `round`, `user_id`) VALUES" +
                  "('${dr.timeRound.dragCard}','${dr.round}','${user.id}')";
          Database.insert(query);
        }
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  @action
  showGraphic() {
    animateClock = "Stop";
    if (db) {
      timeTutorial.total = DateTime.now().difference(user.start!);
      String query =
          "INSERT INTO `time_taken_tutorial_pd`(`total`, `tutorial`, `saw_tutorial`, `user_id`) VALUES (" +
              "'${timeTutorial.total}', '${timeTutorial.tutorial}', '${timeTutorial.sawTutorial}','${user.id}')";
      Database.insert(query);
    }
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              //title: Text("Aviso!"),
              content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(AppLocalizations.of(context).translate('thanks'),
                        style:
                            TextStyle(fontSize: Resize.getHeight(context) / 20),
                        textAlign: TextAlign.center),
                    SizedBox(height: Resize.getHeight(context) / 20),
                    InkWell(
                        child: new Text(
                          AppLocalizations.of(context).translate('feedback'),
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.lightBlue,
                              fontSize: Resize.getHeight(context) / 20),
                        ),
                        onTap: () {
                          launch(variables!.formLink!);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomePage()));
                        })
                  ]),

              actions: <Widget>[
                TextButton(
                    child: Text(
                      AppLocalizations.of(context).translate('ok'),
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 25),
                    ),
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => WelcomePage()));
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
                      // Navigator.popUntil(context, (route) => route== MaterialPageRoute(
                      //     builder: (context)=>
                      //     ChooseGamePage(
                      //     )
                      //   ));
                      Navigator.pop(context);
                      Navigator.pop(context);
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context)=>
                      //     ChooseGamePage(
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
      color: Colors.transparent,
    );
    showResult();
  }
}
