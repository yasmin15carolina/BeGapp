import 'dart:math';

import 'package:flare_flutter/flare_controls.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/Database.dart';
import 'package:teoria_dos_jogos/classes/popup_message_pg.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/classes/soundEffects.dart';
import 'package:teoria_dos_jogos/classes/time_taken_round_pg.dart';
import 'package:teoria_dos_jogos/classes/time_taken_tutorial_pg.dart';
import 'package:teoria_dos_jogos/classes/user.dart';
import 'package:teoria_dos_jogos/public_goods/classes/conditions.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';
import 'package:teoria_dos_jogos/public_goods/pages/distributionTutorial.page.dart';
import 'package:teoria_dos_jogos/public_goods/pages/electionTutorial.page.dart';
import 'package:teoria_dos_jogos/public_goods/pages/messagePage.dart';
import 'package:teoria_dos_jogos/public_goods/store/distribution_store.dart';
import 'package:teoria_dos_jogos/public_goods/store/election_store.dart';
import 'package:teoria_dos_jogos/public_goods/store/round_data_store.dart';
import 'package:teoria_dos_jogos/public_goods/store/runningNumbers.dart';
import 'package:teoria_dos_jogos/public_goods/widgets/electionAnimation.dart';
import 'package:teoria_dos_jogos/widgets/nextAnimation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../pages/welcome.page.dart';
part 'game_store.g.dart';

class Game = _GameBase with _$Game;

abstract class _GameBase with Store {
  final PublicGoodsVariables
      variables; // = new PublicGoodsVariables("default",10,10,3,10,0,5,"default","jogo padrão");
  bool armazenarBD = true;
  final User user;
  PGTimeTutorial? timeTutorial = new PGTimeTutorial();
  final List<PopUpMessagePublicGoods>? messages;
  List<bool> messagesShown = []; //controlar as mensagens que já foram exibidas

  _GameBase(this.user, this.variables, this.roundData, this.tokensCount,
      this.walletCount,
      {this.timeTutorial, this.messages});

  bool lastToPlay = false; //se o participante foi o último a jogar
  bool pagePopped = false; //se o participante voltou a tela
  var context;
  List<RoundData> rounds = [];
  List<int> contributions = [];
  List<int> distributions = [];

  registerRoundData() {
    RoundData rd = new RoundData(
        electionId: roundData.electionId, userTokens: roundData.userTokens);
    rd.id = rounds.length + 1;
    rd.round = roundData.round;
    rd.earning = roundData.earning;
    rd.investment = (roundData.investment == -1)
        ? -1 /*null as int*/ : roundData.investment;
    rd.playersEarning = roundData.playersEarning;
    rd.playersInvestiment = roundData.playersInvestiment;
    rd.positionToken = roundData.positionToken;
    rd.rib = roundData.rib;
    rd.total = roundData.total;
    rd.wallet = roundData.wallet;
    rd.distribution = roundData.distribution;
    rd.election = roundData.election;
    rd.votes = roundData.votes;
    rd.votesScreen = roundData.votesScreen;
    rd.suspended = roundData.suspended;
    rd.suspentions = roundData.suspentions;
    rd.electionCount = roundData.electionCount + 1;
    rd.timeRound = roundData.timeRound;
    rounds.add(rd);
    roundData.timeRound = new PGTimeRound();
    if (rd.investment != -1) contributions.add(rd.investment);
    if (rd.distribution && rd.earning > -1 && rd.investment != -1)
      distributions.add(((rd.earning / rd.rib!) * 100).toInt());

    Conditions conditions = new Conditions(
      context: context,
      rounds: (rd.distribution) ? distributions : contributions,
      roundsData: rounds.toList(),
      variables: variables,
      callElection: callElections,
      clearLists: clearLists,
      nextRound: nextRound,
      nextLevel: checkShowMessageByCriterion, //nextLevel,
      showGraphic: showGraphic,
      distribution: rd.distribution,
      electionEnabled: roundData.election, //(roundData.electionCount>0),
      setDistributionTrue: roundData.setDistributionTrue,
      lostVote: roundData.lostVote,
      suspended: roundData.suspended,
      getSuspensions: roundData.getSuspensions,
      electionCountUp: roundData.electionCountUp,
      distributionStableCountUp: roundData.distributionStableCountUp,
      startSuspension: roundData.startSuspension,
    );
    if (armazenarBD) sendDataToDatabase();

    if (roundData.suspended)
      conditions.endSuspension(rounds, roundData.endSuspension);

    //se houverem mensagens a serem exibidas ao participante
    checkShowMsg(conditions, rd);
  }

  clearLists() {
    contributions.clear();
    distributions.clear();
  }

  checkShowMsg(Conditions conditions, RoundData rd) {
    if (messages!.isNotEmpty) {
      bool showMessage = false;
      int index = -1;
      late int level;
      if (!rd.distribution && !rd.election)
        level = 1;
      else if (rd.distribution && !rd.election)
        level = 2;
      else if (rd.distribution && rd.election) level = 3;
      for (var i = 0; i < messages!.length; i++) {
        if (messages![i].round == roundData.round &&
            !messagesShown[i] &&
            level == messages![i].level) {
          // messagesShown[i] =
          //     true; //exibe a mensagem apenas uma vez durante o jogo
          showMessage = true;
          index = i;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MessagePage(
                  message: messages![i].message,
                  next: () => checkShowMsg(conditions, rd))));
          break;
        }
      }

      if (index > -1) messagesShown[index] = true;
      // if (index > -1) messages.removeAt(index);
      if (!showMessage)
        nextConditions(conditions,
            rd); //se não exibiu nenhuma mensagem, segue para prox rodada
    } else
      nextConditions(conditions, rd);
  }

  checkShowMessageByCriterion() {
    if (messages!.isNotEmpty) {
      bool showMessage = false;
      int index = -1;
      late int level;
      if (!roundData.distribution && !roundData.election)
        level = 1;
      else if (roundData.distribution && !roundData.election)
        level = 2;
      else if (roundData.distribution && roundData.election) level = 3;
      for (var i = 0; i < messages!.length; i++) {
        if (!messagesShown[i] &&
            level - 1 == messages![i].level &&
            messages![i].criterion) {
          // messagesShown[i] =
          //     true; //exibe a mensagem apenas uma vez durante o jogo
          showMessage = true;
          index = i;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MessagePage(
                  message: messages![i].message,
                  next: () => checkShowMessageByCriterion())));
          break;
        }
      }

      if (index > -1) messagesShown[index] = true;
      // if (index > -1) messages.removeAt(index);
      if (!showMessage)
        nextLevel(); //se não exibiu nenhuma mensagem, segue para prox rodada
    } else
      nextLevel(); //se não existem mensagens programas para esse jogo, segue para prox rodada
  }

  nextConditions(Conditions conditions, RoundData rd) {
    //se atingiu o limite de rodadas do nivel sem estabilidade
    if (roundData.round >= variables.maxTrys) {
      if (variables.onlyContribution)
        showGraphic(
            endMessage: AppLocalizations.of(context).translate('thanks'));
      else if (!roundData.distribution) {
        //se a distribuição não esta ativada
        roundData.setDistributionTrue(variables.notRealPlayers);
        nextLevel();
      } else if (!roundData.election) {
        //se a eleição não esta ativada
        roundData.electionCountUp(showGraphic, variables);
        nextLevel();
      } else
        showGraphic();
    } else if (!roundData.suspended && variables.stable > 0)
      conditions.checkStability(
          !(rd.distribution && rd.earning > -1 && rd.investment != -1));

    if (roundData.suspended) nextRound();
  }

  @observable
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @observable
  FlareControls flareControls = new FlareControls();

  @observable
  bool startTiming = true; //se o relogio rodando

  @observable
  bool showPanelTokens = true;

  @observable
  String coinsAnimation = "";

  @observable
  Function coinsEnd = (name) {};

  @observable
  String animateClock = 'Stop'; //nome da animação do relogio

  @observable
  ObservableList<int> tokensList = new ObservableList<int>(); //ordem das fichas

  @observable
  RoundData roundData;

  @observable
  RunningNumbers tokensCount;

  @observable
  RunningNumbers walletCount;

  @observable
  RunningNumbers pigCount = new RunningNumbers(false, false, 0, 0, 1);

  int plasyersLostTime = Random().nextInt(3);

  showGraphic({String endMessage: ""}) async {
    if (endMessage == "")
      endMessage = AppLocalizations.of(context).translate('PGEndGame');
    endMessage += "\n" +
        AppLocalizations.of(context).translate('score') +
        roundData.wallet.toString();
    //  sendDataToDatabase();
    if (armazenarBD) {
      timeTutorial!.total = DateTime.now().difference(user.start!);
      String query =
          "INSERT INTO `time_taken_tutorial_pg` (`total`, `tutorial_main`, `tutorial_distribution`, `tutorial_election`, `saw_main_tutorial`, `saw_distribution_tutorial`, `saw_election_tutorial`, `user_id`) VALUES (" +
              "'${timeTutorial!.total}', '${timeTutorial!.main}', '${timeTutorial!.distribution}', '${timeTutorial!.election}', '${timeTutorial!.sawMain}', '${timeTutorial!.sawDistribution}', '${timeTutorial!.sawElection}', '${user.id}');";
      Database.insert(query);
    }
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              content: WillPopScope(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(endMessage,
                            style: TextStyle(
                                fontSize: Resize.getHeight(context) / 20),
                            textAlign: TextAlign.center),
                        SizedBox(height: Resize.getHeight(context) / 20),
                        InkWell(
                            child: new Text(
                              AppLocalizations.of(context)
                                  .translate('feedback'),
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.lightBlue,
                                  fontSize: Resize.getHeight(context) / 20),
                            ),
                            onTap: () {
                              launch('https://forms.gle/86uhyWx4SgX2v6To6');
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WelcomePage()));
                            })
                      ]),
                  onWillPop: () async {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => WelcomePage()));
                    return true;
                  }),
              // actions: [
              //   FlatButton(
              //     onPressed: (){
              //       Navigator.of(context).pop();
              //       Navigator.of(context).pop();
              //       Navigator.of(context).push(
              //        MaterialPageRoute(builder: (context)=> GraphicPagePG(gameRounds: rounds,variables: variables,))
              //      );
              //     },
              //     child: Text(AppLocalizations.of(context).translate('seeResult'),style: TextStyle(fontSize: MediaQuery.of(context).size.height/20),)),

              // ],
            ));
  }

  sendDataToDatabase() async {
    // String query = "INSERT INTO `users`( `name`, `age`, `gender`, `educationLevel`, `occupation`, `cours`) VALUES (";
    // query += "'${user.name}','${user.age}','${user.gender}','${user.educationLevel}','${user.occupation}','${user.cours}')";

    // var userId= await Database.insertUser(user);
    var userId = user.id;
    print(userId);
    RoundData r = rounds.last;
    // rounds.forEach((r) {
    int suspended = r.suspended ? 1 : 0;
    int distribution = r.distribution ? 1 : 0;
    int votes = r.election ? r.votes : 0;
    int investment = r.investment == -1 ? -1 : r.investment;
    String query =
        "INSERT INTO `public_goods_rounds`(`userId`, `round`, `investment`, `positionToken`, `earning`, `rib`, `wallet`, `distribution`, `suspended`, `electionCount`, `votes`) VALUES (";
    query +=
        "'$userId','${r.id}','$investment','${r.positionToken}','${r.earning}','${r.rib}','${r.wallet}','$distribution','$suspended','${r.electionCount}','$votes')";
    // print(query);
    Database.insert(query);
    query =
        "INSERT INTO `time_taken_round_pg` (`drag_token`, `distribution`, `election`, `round`, `user_id`) VALUES ('${r.timeRound.dragToken}', '${r.timeRound.distribution}', '${r.timeRound.election}', '${r.id}', '$userId')";
    Database.insert(query);
    // });
  }

  @action
  callElections() {
    if (variables.electionRule == 1 || variables.electionRule == 2) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => ElectionAnimation(Resize.getHeight(context) / 2,
                  fontSize: Resize.getWidth(context) / 10, onEndAnimation: () {
                Navigator.pop(context);
                ElectionStore electionStore = new ElectionStore(
                    roundData.electionId,
                    roundData.timeRound.setElection,
                    context,
                    roundData.updateVotes,
                    showGraphic,
                    variables,
                    this.roundData,
                    this.roundData.startSuspension,
                    rounds);
                electionStore.displayElectionScreen(nextRound);
              }));
    } else {
      ElectionStore electionStore = new ElectionStore(
          roundData.electionId,
          roundData.timeRound.setElection,
          context,
          roundData.updateVotes,
          showGraphic,
          variables,
          this.roundData,
          this.roundData.startSuspension,
          rounds);
      electionStore.displayElectionScreen(nextRound);
    }
  }

  //altera variaveis quando pop o widget
  @action
  onDispose() {
    startTiming = false;
    animateClock = "Stop";
    pagePopped = true;
    Navigator.of(context).pop();
  }

  @action
  endRunningNumbers(Function stopRunning) {
    stopRunning();
    registerRoundData();
  }

  @action
  nextRound() {
    // if((roundData.electionCount<2|| variables.electionRule==3 || variables.electionRule==4 ) && !pagePopped){
    if (!pagePopped) {
      // print("NAO JOAGARAMMMM : " + roundData.playersPlay.toString());
      tokensCount.setValues(0, variables.maxTokens);
      tokensCount.startCountUp();
      roundData.userTokens = variables.maxTokens;
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => NextAnimation(
                  -Resize.getWidth(context) /
                      2, //"NAO JOAGARAM  :   "+roundData.playersPlay.toString(),
                  AppLocalizations.of(context).translate('nextRound'),
                  onEndAnimation: () {
                Navigator.of(context).pop();
                cardKey.currentState!.toggleCard();
                startTiming = true;
                tokensList.shuffle();

                (roundData.round == variables.maxTrys)
                    ? roundData.round = 1
                    : roundData.round++;
                blinkPanel();
                callPlayersDelay();

                roundData.roundPoints = 0;
                lastToPlay = false;
                roundData.investment = -1;
                roundData.playersPlay = variables.notRealPlayers;
                pulseTheClock();
              }));
    }
  }

  @action
  nextLevel() {
    // if(roundData.electionCount<2|| variables.electionRule==3 || variables.electionRule==4 && !pagePopped){

    if (!pagePopped) {
      tokensCount.setValues(0, variables.maxTokens);
      tokensCount.startCountUp();
      roundData.userTokens = variables.maxTokens;
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => NextAnimation(-Resize.getWidth(context) / 2,
                  AppLocalizations.of(context).translate('nextLevel'),
                  fontSize: Resize.getHeight(context) / 6, onEndAnimation: () {
                Navigator.pop(context);
                clearLists();
                if (roundData.distribution && roundData.electionCount == -1)
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DistributionTutorial(variables, () {
                                roundData.round = 0;
                                nextRound();
                              }, timeTutorial!)));
                else
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ElectionTutorial(variables, () {
                                //callElections();
                                roundData.round = 0;
                                nextRound();
                                roundData.election = true;
                              }, timeTutorial!)));
              }));
    }
  }

  //Executada quando arrasta a ficha
  @action
  onDragToken(value) {
    if (rounds.isEmpty || rounds.last.round != roundData.round) {
      //registra o investimento,a posição da ficha, para o relogio, reduz as fichas, disabilita as fichas
      // print('here');
      tokensCount.diference = value;
      tokensCount.inicial = variables.maxTokens;
      tokensCount.startCountDown();

      roundData.investment = value;
      roundData.positionToken = tokensList.indexOf(value);
      startTiming = false;
      animateClock = 'Stop';
      roundData.userTokens -= value as int;
      roundData.userTokens = roundData.userTokens;
      if (value > 0) {
        coinsAnimation = "tokensToPig";
        coinsEnd = this.endCoinsToPig;
        flareControls.play("Collect");
      } else if (lastToPlay) {
        lastToPlay = false;
        resultWhenPlayed();
      }
    }
  }

  //função executada quando o participante joga na rodada(não perde a vez)
  @action
  resultWhenPlayed() {
    // print("resultWhenPlayed");
    Future.delayed(Duration(seconds: 2), () async {
      tokensCount.setValues(
        roundData.userTokens.toInt(),
        roundData.userTokens.toInt(),
      );
      tokensCount.startCountDown();
      roundData.userTokens = 0;

      if (roundData.distribution) {
        // print("distribution");
        // roundData.displayDistributionScreen(context,variables,concludeDistribution);
        roundData.calculateRib(variables);
        DistributionStore distributionStore = new DistributionStore(
            roundData.rib!, roundData.timeRound.setDistribution);
        distributionStore.displayDistributionScreen(
            context, variables, concludeDistribution, roundData.distributeRib);
      } else {
        // print("SEM disttibution");
        roundData.generateRound(
            variables); //executa o algoritmo, determina o dinheiro gerado(total)
        roundData.roundPoints = roundData.earning;
        cardKey.currentState!.toggleCard();
        Future.delayed(Duration(seconds: 3), () async {
          showCoins();
        });
      }
    });
  }

  @action
  concludeDistribution() {
    if (roundData.investment == variables.maxTokens && roundData.earning == 0)
      registerRoundData();
    roundData.roundPoints = roundData.earning;
    cardKey.currentState!.toggleCard();
    Future.delayed(Duration(seconds: 3), () async {
      // showCoins();
      (roundData.earning > -1) ? showCoins() : registerRoundData();
    });
  }

  //executado quando o tempo acaba e o jogador perde a vez
  @action
  timeOut() {
    if (!roundData.suspended) {
      // print("timeOut");
      //ativa a animação do relogio
      animateClock = 'Shake';
      startTiming = false;
      //Toca o despertador
      SoundEffects.play('audio/ClockBell.mp3');

      //gera o rendimento para os outros jogadores
      roundData.generateRoundWhenLostTime(variables);
      //vira o porquinho e mostra o valor gerado para os outros jogadores
      cardKey.currentState!.toggleCard();

      Future.delayed(new Duration(seconds: 1, milliseconds: 50), () async {
        //pausa a animação do relogio
        animateClock = 'Stop';
        // nextLevel(true);
        registerRoundData();
      });
    }
  }

  //chama os "Future"  com o delay dos outros jogadores
  @action
  callPlayersDelay() {
    int roundDelay = Random().nextInt(variables.time - variables.time ~/ 3) +
        variables.time ~/ 3;
    roundDelay *= 1000;
    int totalDelay = roundDelay;
    int newDelay = Random().nextInt(3);
    while (newDelay == plasyersLostTime && newDelay != 0) {
      newDelay = Random().nextInt(3);
    }
    plasyersLostTime = newDelay;
    roundData.playersPlay = variables.notRealPlayers;

    Future.delayed(
        Duration(
            milliseconds: (plasyersLostTime == 0)
                ? totalDelay
                : (1000 * variables.time)), () async {
      if (roundData.suspended) {
        startTiming = false;
        animateClock = "Stop";
        //gera o rendimento para os outros jogadores
        roundData.generateRoundWhenLostTime(variables);
        //vira o porquinho e mostra o valor gerado para os outros jogadores
        cardKey.currentState!.toggleCard();

        Future.delayed(new Duration(seconds: 1, milliseconds: 50), () async {
          registerRoundData();
        });
      }
      if (!startTiming && roundData.investment > -1)
        resultWhenPlayed();
      else
        lastToPlay = true;
    });

    List<int> delays = roundData.definePlayersDelay(roundDelay, variables);
    delays.forEach((d) {
      Future.delayed(Duration(milliseconds: d), () async {
        if (roundData.playersPlay > plasyersLostTime) {
          roundData.playersPlay--;
        }
      });
    });
  }

  @action
  onCoinsEndAnimation(name) async {
    // print("onCoinsEndAnimation");
    if (roundData.earning > 0 || roundData.investment < variables.maxTokens) {
      SoundEffects.play('audio/CollectCoin.mp3');
    }
    // registerRoundData();
    roundData.getPoints(variables);
    walletCount.setValues(roundData.wallet.toInt(), roundData.roundPoints);
    walletCount.startCountUp();
    roundData.updateWallet(variables);

    coinsAnimation = "";
  }

  @action
  endCoinsToPig(name) {
    // print('END COINS TO PIG');
    coinsAnimation = "";

    if (lastToPlay) {
      lastToPlay = false;
      // print('LAST TO PLAY');
      Future.delayed(Duration(seconds: 2), () {
        resultWhenPlayed();
      });
    }
  }

  @action
  remainingTokensToPig(name) {
    pigCount.setValues(
        roundData.earning, variables.maxTokens - roundData.investment);
    pigCount.startCountUp();

    coinsAnimation = "";
  }

  @action
  endCountEarningTokens() {
    pigCount.stop();
    roundData.getPoints(variables);
    coinsAnimation = "pigToWallet";
    coinsEnd = this.onCoinsEndAnimation;
    flareControls.play("Collect");
    // onCoinsEndAnimation("End");
  }

  @action
  showCoins() {
    // print("aa" + coinsAnimation);

    if (roundData.investment < variables.maxTokens) {
      coinsAnimation = "tokensToPig";
      coinsEnd =
          //  this.remainingTokensToPig;
          (name) {};
      flareControls.play("Collect");
      Future.delayed(Duration(seconds: 2), () {
        remainingTokensToPig('Collect');
      });
      //coinsAnimation="tokensToWallet";
    } else if (roundData.earning > 0) {
      coinsAnimation = "pigToWallet";
      coinsEnd = this.onCoinsEndAnimation;
      flareControls.play("Collect");
    }

    // print(coinsAnimation);
  }

  //se o cronometro esta funcionando, ativa a animação pulse do relogio
  @action
  pulseTheClock() {
    if (startTiming) {
      animateClock = 'Pulse';
    }
  }

  @action
  blinkPanel() {
    showPanelTokens = true;
    Future.delayed(Duration(seconds: 2), () {
      showPanelTokens = false;
    });
  }
}
