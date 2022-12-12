import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';
import 'package:teoria_dos_jogos/public_goods/store/round_data_store.dart';
import 'package:teoria_dos_jogos/public_goods/widgets/election.dart';
import 'package:teoria_dos_jogos/widgets/popUpWithTimer.dart';
part 'election_store.g.dart';

class ElectionStore = _ElectionStoreBase with _$ElectionStore;

abstract class _ElectionStoreBase with Store {
  int electionId;
  Function electionTime;
  Function updateVotes;
  Function showGraphic;
  RoundData roundData;
  Function startSuspension;
  PublicGoodsVariables variables;
  List<RoundData> rounds;
  var context;
  _ElectionStoreBase(
      this.electionId,
      this.electionTime,
      this.context,
      this.updateVotes,
      this.showGraphic,
      this.variables,
      this.roundData,
      this.startSuspension,
      this.rounds);

  displayElectionScreen(Function nextRound) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              child: ElectionPopUp(
                electionId,
                variables.notRealPlayers,
                variables.timeElection,
                concludeElection,
                nextRound,
                electionTime: electionTime,
              ),
            ));
  }

  concludeElection(vote, players, Function nextRound) async {
    int votes = 0;
    if (vote == electionId) {
      votes = players + 1;
    } else
      votes = players;

    // int unfair = 100~/(1+variables.notRealPlayers);
    bool wasUnfair = ((rounds.last.earning / rounds.last.rib!) * 100).toInt() >
        variables.unfairDistribution;

    if (variables.electionRule == 2) {
      List<RoundData> list =
          rounds.sublist(rounds.length - variables.stable, rounds.length);
      if (list.first.votes <= list.last.votes && !wasUnfair) {
        votes = updateVotes(
            votes, variables.electionRule, true); //foi honesto e ganhou votos
        print('ganhou');
      } else
        votes = updateVotes(votes, variables.electionRule, false);
    } else
      votes = updateVotes(votes, variables.electionRule, false);

    String suspendedRounds =
        (variables.electionRule == 4) ? "1" : "${variables.waitingRounds}";

    if (((votes == ((variables.notRealPlayers + 1) ~/ 2)) ||
            variables.electionRule == 4) &&
        votes > 0 &&
        wasUnfair) {
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => Dialog(
                  child: PopUpWithTimer(
                AppLocalizations.of(context).translate('youGotSuspended1.1') +
                    suspendedRounds +
                    AppLocalizations.of(context)
                        .translate('youGotSuspended1.2'),
                callback: nextRound,
              )));
      startSuspension(showGraphic, variables);
    } else
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => Dialog(
              child: PopUpWithTimer(
                  AppLocalizations.of(context).translate('youWonElections1.1') +
                      "$votes" +
                      AppLocalizations.of(context)
                          .translate('youWonElections1.2'),
                  callback: nextRound)));
  }
}
