import 'package:mobx/mobx.dart';
import 'package:teoria_dos_jogos/classes/time_taken_round_pd.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/classes/dilemmaVariables.dart';
part 'dilemmaround_store.g.dart';

class DilemmaRound = _DilemmaRoundBase with _$DilemmaRound;

abstract class _DilemmaRoundBase with Store {
  PDTimeRound timeRound = new PDTimeRound();
  int? oponentChoice;
  int? userChoice;
  bool lostRound = false;
  int stableCount = 0;
  @observable
  int round = 1;
  int oponentPoints = 0;
  int userPoints = 0;

  @observable
  bool seeYourPoints = false;

  @observable
  bool seeOtherPoints = false;

  @observable
  bool yourRand = false;

  @observable
  bool otherRand = false;

  @observable
  String result = "";

  _DilemmaRoundBase(
      {this.round: 1,
      this.oponentChoice,
      this.userChoice,
      this.userPoints: 0,
      this.oponentPoints: 0,
      this.lostRound: false,
      this.seeYourPoints: false,
      this.seeOtherPoints: false,
      this.yourRand: true,
      this.otherRand: true,
      this.stableCount: 0});

  @action
  calculateResult(DilemmaVariables dilemmaVariables) {
    // compete 1 , coopera 0
    // confessa 1, nao confessa 0
    // defect 1 cooperate 0
    if (userChoice == 1 && oponentChoice == 1) {
      result = "bothCompete";
      userPoints += dilemmaVariables.bothDefect;
      oponentPoints += dilemmaVariables.bothDefect;
    } else if (userChoice == 1 && oponentChoice == 0) {
      result = "userWins";
      userPoints += dilemmaVariables.defectWin;
      oponentPoints += dilemmaVariables.cooperateLoses;
    } else if (userChoice == 0 && oponentChoice == 1) {
      result = "userLoses";
      userPoints += dilemmaVariables.cooperateLoses;
      oponentPoints += dilemmaVariables.defectWin;
    } else {
      result = "bothCooperate";
      userPoints += dilemmaVariables.bothCooperate;
      oponentPoints += dilemmaVariables.bothCooperate;
    }
    print("user: $userPoints  pc: $oponentPoints");
    return;
  }

  printaLista(List<DilemmaRound> lista) {
    int i = 0;
    String user = "";
    String computer = "";
    for (i = 0; i < lista.length; i++) {
      if (lista[i].userChoice == 0)
        user = "coopera";
      else
        user = "delata";
      if (lista[i].oponentChoice == 0)
        computer = "coopera";
      else
        computer = "delata";
      var round = i + 1;
      // String s = "rodada: "+round.toString()+" pc: "+lista[i].oponentChoice.toString()+" usuario: "+lista[i].userChoice.toString()+"\n";
      String s = "rodada: " +
          round.toString() +
          " pc: " +
          computer +
          " usuario: " +
          user +
          "\n";
      print(s);
    }
    print("\n");
  }
}
