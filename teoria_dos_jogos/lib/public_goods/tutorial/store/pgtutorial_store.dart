import 'dart:math';

import 'package:flare_flutter/flare_controls.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/soundEffects.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';
import 'package:teoria_dos_jogos/public_goods/pages/Graphic.page.dart';
import 'package:teoria_dos_jogos/public_goods/store/round_data_store.dart';
import 'package:teoria_dos_jogos/public_goods/store/runningNumbers.dart';
import 'package:teoria_dos_jogos/widgets/nextAnimation.dart';
part 'pgtutorial_store.g.dart';

class TutorialGameStore = _TutorialGameStoreBase with _$TutorialGameStore;

abstract class _TutorialGameStoreBase with Store {
  final PublicGoodsVariables variables;
  Function tutorialNext;
  _TutorialGameStoreBase(this.tutorialNext, this.variables, this.roundData,
      this.tokensCount, this.walletCount);

  bool lastToPlay = false; //se o participante foi o último a jogar
  var context;
  List<RoundData> rounds = [];
  List<int> contributions = [];
  List<int> distributions = [];
  // List<String> levels = ['contribution','distribution','election'];
  // int level=0;

  registerRoundData() {
    RoundData rd = new RoundData(
        electionId: roundData.electionId, userTokens: roundData.userTokens);
    rd.round = roundData.round;
    rd.earning = roundData.earning;
    rd.investment =
        (roundData.investment == -1) ? null as int : roundData.investment;
    rd.playersEarning = roundData.playersEarning;
    rd.playersInvestiment = roundData.playersInvestiment;
    rd.positionToken = roundData.positionToken;
    rd.rib = roundData.rib;
    rd.total = roundData.total;
    rd.wallet = roundData.wallet;
    rd.distribution = roundData.distribution;
    rounds.add(rd);

    if (rd.round < variables.maxTrys) {
      if (rd.round == 1) {
        tutorialNext();
        Future.delayed(Duration(seconds: 5), () {
          tutorialNext();
          nextRound();
        });
      } else
        nextRound();
    } else
      tutorialNext();
    // if(rd.contribution!=null)contributions.add(rd.contribution);
    // if(rd.distribution && rd.earning>-1)distributions.add( ((rd.earning/rd.rib)*100).toInt() );

    // Conditions conditions = new Conditions(
    //   rounds: (rd.distribution)?distributions:contributions,
    //   callElection: callElections,
    //   clearLists: clearLists,
    //   distribution: rd.distribution,
    //   nextRound: nextRound,
    //   setDistributionTrue: roundData.setDistributionTrue
    // );
    // if(rd.round==variables.maxTrys)showGraphic();
    // else conditions.checkStability();
  }

  clearLists() {
    contributions.clear();
    distributions.clear();
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

  @observable
  Function coinsEnd = (name) {};

  showGraphic() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Text(
                AppLocalizations.of(context).translate('thanks'),
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 20),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GraphicPagePG(
                                gameRounds: rounds,
                                variables: variables,
                              )));
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('seeResult'),
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 20),
                    )),
              ],
            ));

    onDispose();
  }

  @action
  nextLevel() {
    if (roundData.distribution) callElections();
    roundData.distribution = true;
  }

  @action
  callElections() {
    //  ElectionStore electionStore= new ElectionStore(roundData.electionId);
    //  electionStore.displayElectionScreen(context, variables, nextRound);
  }

  //altera variaveis quando pop o widget
  @action
  onDispose() {
    startTiming = false;
    animateClock = "Stop";
  }

  @action
  endRunningNumbers(Function stopRunning) {
    stopRunning();
    registerRoundData();
  }

  @action
  nextRound() {
    tokensCount.setValues(0, variables.maxTokens);
    tokensCount.startCountUp();
    roundData.userTokens = variables.maxTokens;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => NextAnimation(-MediaQuery.of(context).size.width / 2,
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
              // print(DateTime.now());
              roundData.playersPlay = variables.notRealPlayers;
              pulseTheClock();
            }));
  }

  //Executada quando arrasta a ficha
  @action
  onDragToken(value) {
    if (rounds.isEmpty || rounds.last.round != roundData.round) {
      //registra o investimento,a posição da ficha, para o relogio, reduz as fichas, disabilita as fichas
      if (roundData.round == 1) tutorialNext();
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
    print("resultWhenPlayed");
    Future.delayed(Duration(seconds: 2), () async {
      tokensCount.setValues(
        roundData.userTokens.toInt(),
        roundData.userTokens.toInt(),
      );
      tokensCount.startCountDown();
      roundData.userTokens = 0;

      // print("SEM disttibution");
      roundData.generateRound(
          variables); //executa o algoritmo, determina o dinheiro gerado(total)
      showCoins();
      roundData.roundPoints = roundData.earning;
      cardKey.currentState!.toggleCard();
    });
  }

  @action
  concludeDistribution() {
    (roundData.earning > -1) ? showCoins() : registerRoundData();
    cardKey.currentState!.toggleCard();
    // registerRoundData();
  }

  //executado quando o tempo acaba e o jogador perde a vez
  @action
  timeOut() {
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

  //chama os "Future"  com o delay dos outros jogadores
  @action
  callPlayersDelay() {
    int roundDelay = Random().nextInt(variables.time - variables.time ~/ 3) +
        variables.time ~/ 3;
    roundDelay *= 1000;
    int totalDelay = roundDelay;

    roundData.playersPlay = variables.notRealPlayers;

    Future.delayed(Duration(milliseconds: totalDelay), () async {
      if (!startTiming && roundData.investment > -1)
        resultWhenPlayed();
      else
        lastToPlay = true;
    });

    List<int> delays = roundData.definePlayersDelay(roundDelay, variables);
    delays.forEach((d) {
      Future.delayed(Duration(milliseconds: d), () async {
        if (roundData.playersPlay > 0) {
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

    print(coinsAnimation);
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
