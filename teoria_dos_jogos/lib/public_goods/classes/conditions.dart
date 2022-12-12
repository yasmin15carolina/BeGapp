// ignore_for_file: unused_local_variable

import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';
import 'package:teoria_dos_jogos/public_goods/store/round_data_store.dart';

class Conditions {
  final context;
  final List<int>? rounds;
  final bool? distribution;
  final bool? electionEnabled;
  final Function? setDistributionTrue;
  final Function? callElection;
  final Function? nextRound;
  final Function? nextLevel;
  final Function? clearLists;
  final Function? lostVote;
  final Function? startSuspension;
  final Function? getSuspensions;
  final Function? electionCountUp;
  final Function? distributionStableCountUp;
  final Function? showGraphic;
  final PublicGoodsVariables? variables;
  final List<RoundData>? roundsData;
  bool lostVoteThisRound = false;
  bool? suspended;
  bool next = false;
  bool endGame = false;
  bool readyToElection = false;
  Conditions(
      {this.context,
      this.rounds,
      this.distribution,
      this.electionEnabled,
      this.setDistributionTrue,
      this.callElection,
      this.suspended,
      this.nextLevel,
      this.nextRound,
      this.clearLists,
      this.variables,
      this.lostVote,
      this.electionCountUp,
      this.showGraphic,
      this.startSuspension,
      this.getSuspensions,
      this.distributionStableCountUp,
      this.roundsData});

  checkStability(bool lostTime) {
    if (distribution! &&
        (variables!.electionRule == 2 || variables!.electionRule == 4) &&
        !lostTime) checkLostVote(rounds!);

    if (!endGame) {
      if (rounds!.length >= variables!.stable) {
        if (!distribution!)
          isStableToDistribution(rounds!);
        else {
          isReadyToElection(
            rounds!,
          );
        }
      } else if ((variables!.electionRule == 3 ||
              variables!.electionRule == 4) &&
          distribution! &&
          electionEnabled!) {
        checkElection();
      } //else checkIntermitentElection();

      if (next)
        clearLists!();
      else if (((variables!.electionRule != 3 &&
                  variables!.electionRule != 4) ||
              !electionEnabled!) &&
          !readyToElection) {
        // || (variables.electionRule==3 && variables.electionRule==4 && electionEnabled)){
        if (!endGame) nextRound!();
      }
    }
  }

  isStableToDistribution(
    List<int> contributions,
  ) {
    //contribution => distribution
    List<int> values = contributions.sublist(
        contributions.length - variables!.stable, contributions.length);
    values.sort();
    if (values.last - values.first <= variables!.contributionsVariation) {
      //se o exprimento so possui a fase de contribuição e atingiu estabilidade, encerra
      if (variables!.onlyContribution) {
        next = false;
        endGame = true;
        showGraphic!(
            endMessage: AppLocalizations.of(context).translate('thanks'));
      } else {
        //se houver fase de distribuição então vai para esta
        setDistributionTrue!(variables!.notRealPlayers);

        nextLevel!();
        next = true;
      }
    }
  }

  checkLostVote(
    List<int> distributions,
  ) async {
    // int unfair = 100~/(1+variables.notRealPlayers);
    if (variables!.electionRule == 2 || electionEnabled!) if (distributions
            .last >
        variables!.unfairDistribution) {
      int votes = lostVote!(variables);
      lostVoteThisRound = true;
      if (votes == variables!.notRealPlayers - variables!.limitVotes &&
          variables!.electionRule == 4) {
        next = false;
        endGame = true;
        showGraphic!(
            endMessage:
                AppLocalizations.of(context).translate('PGEndGameLost'));
      }
    }
  }

  isReadyToElection(List<int> distributions) async {
    //distribution => election
    List<int> values = distributions.sublist(
        distributions.length - variables!.stable, distributions.length);
    values.sort();
    bool finishOnDistributionStable = false;
    bool stable = (values.first > variables!.unfairDistribution ||
        values.last <= variables!.unfairDistribution);

    if (values.last - values.first <= variables!.distributionVariation &&
        stable) {
      //Estabilidade na eleição
      next = true;
      finishOnDistributionStable =
          distributionStableCountUp!(showGraphic, variables);
      if (((variables!.electionRule == 1 || variables!.electionRule == 2) &&
              !electionEnabled!) ||
          (variables!.electionRule == 3 || variables!.electionRule == 4)) {
        checkElection(
            finishOnDistributionStable: finishOnDistributionStable,
            dStable: true);
      }
    } else if (((variables!.electionRule == 3 ||
                variables!.electionRule == 4) &&
            electionEnabled!) ||
        ((variables!.electionRule == 1 || variables!.electionRule == 2) &&
            !electionEnabled!)) {
      checkElection();
    }
    if (!finishOnDistributionStable) {
      checkIntermitentElection();
    }
  }

//chamado para as eleições das regras 1 e 2, eleição a cada 5 rodadas
  checkIntermitentElection() {
    if ((variables!.electionRule == 1 || variables!.electionRule == 2) &&
        electionEnabled!) {
      bool lostTime = false;
      bool wasSuspended = roundsData!.last.suspended ||
          roundsData![roundsData!.length - variables!.waitingRounds].suspended;
      List<RoundData> toRemove = [];
      roundsData!.forEach((r) {
        if ((!r.distribution || r.earning <= -1 || r.investment == -1)) {
          lostTime = true;
          toRemove.add(r); //a rodada perdida não conta
        }
      });
      roundsData!.removeWhere((e) => toRemove.contains(e));
      if (roundsData!.length < variables!.stable) return;

      List<RoundData> list = roundsData!
          .sublist(roundsData!.length - variables!.stable, roundsData!.length);

      // bool wasSuspended = false;
      // if(lostTime)
      // list.forEach((r) {
      //   if(r.suspended)wasSuspended=true; //Os rounds suspensos não contam para as eleições intermitentes
      // });

      if (list.first.electionCount == list.last.electionCount &&
          !wasSuspended) {
        //se a segunda suspensão for ocorrer, o jogo termina.
        if ((list.first.votes > list.last.votes || lostVoteThisRound) &&
            roundsData!.last.getSuspensions() == 1) {
          showGraphic!(
              endMessage:
                  AppLocalizations.of(context).translate('PGEndGameLost'));
          next = true;
          return;
        } else
          checkElection();
      }
    }
  }

  checkElection({bool finishOnDistributionStable: false, bool dStable: false}) {
    bool b = ((variables!.electionRule == 1 || variables!.electionRule == 2) &&
                (dStable || electionEnabled!)) ||
            (variables!.electionRule == 3 || variables!.electionRule == 4)
        ? electionCountUp!(showGraphic, variables)
        : false;
    if (b && !finishOnDistributionStable) {
      readyToElection = true;
      if (electionEnabled!) {
        (roundsData!.last.suspended) ? nextRound!() : callElection!();
      } else
        nextLevel!();
    }
  }

  endSuspension(List<RoundData> rounds, Function suspensionOver) {
    if (rounds.last.suspended) {
      int aux = 0;
      if (variables!.electionRule == 4) {
        suspended = false;
        suspensionOver(variables);
        return;
      }
      for (var i = rounds.length - 1;
          i >= rounds.length - variables!.waitingRounds;
          i--) {
        if (rounds[i].suspended) aux++;
      }
      if (aux == variables!.waitingRounds) {
        suspended = false;
        suspensionOver(variables);
        return;
      }
    }
  }
}
