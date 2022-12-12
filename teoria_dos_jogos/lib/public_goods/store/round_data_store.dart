import 'dart:math';

import 'package:mobx/mobx.dart';
import 'package:teoria_dos_jogos/classes/time_taken_round_pg.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';
part 'round_data_store.g.dart';

class RoundData = _RoundDataBase with _$RoundData;

abstract class _RoundDataBase with Store {
  PGTimeRound timeRound = new PGTimeRound();
  bool distribution = false;
  bool election = false;
  int electionId;
  int votes = 0;
  int suspentions = 0;
  @observable
  int votesScreen = 0;
  int electionCount = -1;
  int distributionStable = 0;
  int distributionStableAfterSecondElection = 0;

  @observable
  bool suspended = false;

  @observable
  int round = 1;

  int id = 0;

  @observable
  int userTokens;

  @observable
  int wallet = 0; //dinheiro na carteira

  int? positionToken; //posição da ficha investida
  int investment = -1; //quantas fichas investiu

  int? total; //investimento total(todos os jogadores)
  int? rib; //rendimento
  @observable
  int earning = 0; //ganho retornado ao jogador

  @observable
  int playersPlay = 0; //simula delay dos jogadores para jogar

  int roundPoints = 0;
  List? playersInvestiment;
  List? playersEarning;

  _RoundDataBase({
    this.electionId: 0,
    this.userTokens: 0,

    // this.distribution:false,this.distributionStable,this.distributionStableAfterSecondElection,this.earning,this.election:false,
    // this.electionCount,this.investment,this.round,this.rib, this.roundPoints,this.suspended,this.suspentions,
    // this.votes,this.votesScreen,this.wallet
  });

  printData() {
    //  RoundData roundData = new RoundData(electionId:this.electionId,userTokens:this.userTokens,
    //   distribution:this.distribution,distributionStable:this.distributionStable,
    //   distributionStableAfterSecondElection:this.distributionStableAfterSecondElection,earning:this.earning,
    //   election:this.election,electionCount:this.electionCount,investment:this.investment,round:this.round,rib:this.rib,
    //   roundPoints: this.roundPoints,suspended:this.suspended,suspentions:this.suspentions,votes:this.votes,
    //   votesScreen:this.votesScreen,wallet:this.wallet);
    // print(
    //     "rounds.add(new RoundData roundData = new RoundData(electionId:this.electionId,userTokens:this.userTokens,distribution:this.distribution,distributionStable:this.distributionStable,distributionStableAfterSecondElection:this.distributionStableAfterSecondElection,earning:this.earning,election:this.election,electionCount:this.electionCount,investment:this.investment,round:this.round,rib:this.rib,roundPoints: this.roundPoints,suspended:this.suspended,suspentions:this.suspentions,votes:this.votes,votesScreen:this.votesScreen,wallet:this.wallet));");
  }

  setDistributionTrue(nPlayers) {
    distribution = true;
    votes = nPlayers;
    // this.votesScreen=this.votes;
  }

  int lostVote(PublicGoodsVariables variables) {
    if ((votes > ((variables.notRealPlayers + 1) ~/ 2)) ||
        suspentions == 1 ||
        variables.electionRule == 4) votes--;
    return votes;
  }

  @action
  updateVotes(int votes, int rule, bool gainedVotes) {
    this.votesScreen = this.votes;
    if ((rule != 4 && rule != 2) || gainedVotes) {
      this.votesScreen = votes;
      this.votes = votes;
    }
    return this.votesScreen;
  }

  @action
  endSuspension(PublicGoodsVariables variables) {
    suspended = false;
    // if(variables.electionRule!=4)
    // votes = variables.notRealPlayers;
    // votesScreen  = variables.notRealPlayers;
  }

  @action
  startSuspension(Function showGraphic, PublicGoodsVariables variables) {
    suspentions++;
    suspended = true;
  }

  bool electionCountUp(Function showGraphic, PublicGoodsVariables variables) {
    electionCount++;
    // if(electionCount==2 && (variables.electionRule==2 || variables.electionRule==1)){
    //   showGraphic();
    //   return false;
    // }else return true;
    return true;
  }

  bool distributionStableCountUp(
      Function showGraphic, PublicGoodsVariables variables) {
    distributionStable++;
    if (electionCount >= 2)
      distributionStableAfterSecondElection++; //Estabilidade apos segunda eleição, regra 1,2
    if (distributionStable == 2 &&
        (variables.electionRule == 3 || variables.electionRule == 4)) {
      showGraphic();
      return true;
    } else if (distributionStableAfterSecondElection == 1 &&
        electionCount >= 2 &&
        (variables.electionRule == 1 || variables.electionRule == 2)) {
      showGraphic();
      return true;
    } else
      return false;
  }

  distributeRib(userEarning, otherPlayers) {
    //distribui o redimento de acordo com a escolha do adm
    earning = userEarning;

    playersEarning = List.generate(otherPlayers, (index) {
      return (earning == -1)
          ? rib! ~/ (otherPlayers)
          : (rib! + userEarning) ~/ (otherPlayers);
    });
  }

  calculateRib(PublicGoodsVariables variables) {
    earning = 0;
    //gera o investimnento dos outros jogadores
    playersInvestiment = List.generate(variables.notRealPlayers, (index) {
      return Random().nextInt(variables.maxTokens + 1);
    });

    //soma as fichas investidas por todos
    total = investment;
    playersInvestiment!.forEach((element) {
      total = total! + element! as int;
    });

    //cálculo do rendimento segundo o fator definido
    rib = total! * variables.factor;
  }

  generateRound(PublicGoodsVariables variables) {
    // print('begin');
    calculateRib(variables);

    //distribui o redimento de forma igualitaria (o operador ~/ divide e converte para int)
    earning = rib! ~/ (variables.notRealPlayers + 1);
    //arredonda sempre pra cima
    if ((rib! % (variables.notRealPlayers + 1)) /
                (variables.notRealPlayers + 1) <=
            0.5 &&
        (rib! % (variables.notRealPlayers + 1)) /
                (variables.notRealPlayers + 1) >
            0) earning++;

    playersEarning = List.generate(variables.notRealPlayers, (index) {
      return earning;
    });

    // print('finish');
  }

  getPoints(PublicGoodsVariables variables) {
    roundPoints = variables.maxTokens - investment + earning; //obtido na rodada
  }

  int getSuspensions() {
    return suspentions;
  }

  updateWallet(PublicGoodsVariables variables) {
    wallet +=
        roundPoints; //variables.maxTokens-investment+earning; //atualiza a carteira
  }

  generateRoundWhenLostTime(PublicGoodsVariables variables) {
    //gera o investimnento dos outros jogadores
    playersInvestiment = List.generate(variables.notRealPlayers, (index) {
      return Random().nextInt(variables.maxTokens + 1);
    });

    //o jogador perdeu a vez, seu investimento foi nulo e a varivel investiment recebe -1
    total = 0;
    investment = -1;
    //soma as fichas investidas por todos
    playersInvestiment!.forEach((element) {
      total = total! + element! as int;
    });

    //cálculo do rendimento segundo o fator definido
    rib = total! * variables.factor;

    //distribui o redimento de forma igualitaria (o operador ~/ divide e converte para int)
    earning = 0; //rib~/(nPlayers);

    playersEarning = List.generate(variables.notRealPlayers, (index) {
      return earning;
    });
  }

//define o delay dos outros jogadores
  definePlayersDelay(int roundDelay, PublicGoodsVariables variables) {
    int total = roundDelay;
    playersPlay = variables.notRealPlayers;

    List<int> delays = [];
    int d = 0;
    for (int i = 0; i < variables.notRealPlayers; i++) {
      if (roundDelay > 0) {
        // int d = Random().nextInt(roundDelay-(roundDelay~/3))+roundDelay~/3;
        d = Random().nextInt(roundDelay);
        while (total - d < total / 2 &&
            i < variables.notRealPlayers / 2 &&
            roundDelay > 1) {
          d = Random().nextInt(roundDelay);
        }
        delays.add(d);
        roundDelay -= delays[i];
      } else
        delays.add(0);
    }

    for (int i = 1; i < variables.notRealPlayers; i++) {
      delays[i] += delays[i - 1];
    }
    delays.forEach((element) {
      // print(element.toString());
    });
    return delays;
  }
}
