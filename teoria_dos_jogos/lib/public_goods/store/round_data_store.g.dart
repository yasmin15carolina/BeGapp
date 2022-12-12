// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round_data_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RoundData on _RoundDataBase, Store {
  final _$votesScreenAtom = Atom(name: '_RoundDataBase.votesScreen');

  @override
  int get votesScreen {
    _$votesScreenAtom.reportRead();
    return super.votesScreen;
  }

  @override
  set votesScreen(int value) {
    _$votesScreenAtom.reportWrite(value, super.votesScreen, () {
      super.votesScreen = value;
    });
  }

  final _$suspendedAtom = Atom(name: '_RoundDataBase.suspended');

  @override
  bool get suspended {
    _$suspendedAtom.reportRead();
    return super.suspended;
  }

  @override
  set suspended(bool value) {
    _$suspendedAtom.reportWrite(value, super.suspended, () {
      super.suspended = value;
    });
  }

  final _$roundAtom = Atom(name: '_RoundDataBase.round');

  @override
  int get round {
    _$roundAtom.reportRead();
    return super.round;
  }

  @override
  set round(int value) {
    _$roundAtom.reportWrite(value, super.round, () {
      super.round = value;
    });
  }

  final _$userTokensAtom = Atom(name: '_RoundDataBase.userTokens');

  @override
  int get userTokens {
    _$userTokensAtom.reportRead();
    return super.userTokens;
  }

  @override
  set userTokens(int value) {
    _$userTokensAtom.reportWrite(value, super.userTokens, () {
      super.userTokens = value;
    });
  }

  final _$walletAtom = Atom(name: '_RoundDataBase.wallet');

  @override
  int get wallet {
    _$walletAtom.reportRead();
    return super.wallet;
  }

  @override
  set wallet(int value) {
    _$walletAtom.reportWrite(value, super.wallet, () {
      super.wallet = value;
    });
  }

  final _$earningAtom = Atom(name: '_RoundDataBase.earning');

  @override
  int get earning {
    _$earningAtom.reportRead();
    return super.earning;
  }

  @override
  set earning(int value) {
    _$earningAtom.reportWrite(value, super.earning, () {
      super.earning = value;
    });
  }

  final _$playersPlayAtom = Atom(name: '_RoundDataBase.playersPlay');

  @override
  int get playersPlay {
    _$playersPlayAtom.reportRead();
    return super.playersPlay;
  }

  @override
  set playersPlay(int value) {
    _$playersPlayAtom.reportWrite(value, super.playersPlay, () {
      super.playersPlay = value;
    });
  }

  final _$_RoundDataBaseActionController =
      ActionController(name: '_RoundDataBase');

  @override
  dynamic updateVotes(int votes, int rule, bool gainedVotes) {
    final _$actionInfo = _$_RoundDataBaseActionController.startAction(
        name: '_RoundDataBase.updateVotes');
    try {
      return super.updateVotes(votes, rule, gainedVotes);
    } finally {
      _$_RoundDataBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic endSuspension(PublicGoodsVariables variables) {
    final _$actionInfo = _$_RoundDataBaseActionController.startAction(
        name: '_RoundDataBase.endSuspension');
    try {
      return super.endSuspension(variables);
    } finally {
      _$_RoundDataBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic startSuspension(
      Function showGraphic, PublicGoodsVariables variables) {
    final _$actionInfo = _$_RoundDataBaseActionController.startAction(
        name: '_RoundDataBase.startSuspension');
    try {
      return super.startSuspension(showGraphic, variables);
    } finally {
      _$_RoundDataBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
votesScreen: ${votesScreen},
suspended: ${suspended},
round: ${round},
userTokens: ${userTokens},
wallet: ${wallet},
earning: ${earning},
playersPlay: ${playersPlay}
    ''';
  }
}
