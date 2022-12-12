// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Game on _GameBase, Store {
  final _$cardKeyAtom = Atom(name: '_GameBase.cardKey');

  @override
  GlobalKey<FlipCardState> get cardKey {
    _$cardKeyAtom.reportRead();
    return super.cardKey;
  }

  @override
  set cardKey(GlobalKey<FlipCardState> value) {
    _$cardKeyAtom.reportWrite(value, super.cardKey, () {
      super.cardKey = value;
    });
  }

  final _$flareControlsAtom = Atom(name: '_GameBase.flareControls');

  @override
  FlareControls get flareControls {
    _$flareControlsAtom.reportRead();
    return super.flareControls;
  }

  @override
  set flareControls(FlareControls value) {
    _$flareControlsAtom.reportWrite(value, super.flareControls, () {
      super.flareControls = value;
    });
  }

  final _$startTimingAtom = Atom(name: '_GameBase.startTiming');

  @override
  bool get startTiming {
    _$startTimingAtom.reportRead();
    return super.startTiming;
  }

  @override
  set startTiming(bool value) {
    _$startTimingAtom.reportWrite(value, super.startTiming, () {
      super.startTiming = value;
    });
  }

  final _$showPanelTokensAtom = Atom(name: '_GameBase.showPanelTokens');

  @override
  bool get showPanelTokens {
    _$showPanelTokensAtom.reportRead();
    return super.showPanelTokens;
  }

  @override
  set showPanelTokens(bool value) {
    _$showPanelTokensAtom.reportWrite(value, super.showPanelTokens, () {
      super.showPanelTokens = value;
    });
  }

  final _$coinsAnimationAtom = Atom(name: '_GameBase.coinsAnimation');

  @override
  String get coinsAnimation {
    _$coinsAnimationAtom.reportRead();
    return super.coinsAnimation;
  }

  @override
  set coinsAnimation(String value) {
    _$coinsAnimationAtom.reportWrite(value, super.coinsAnimation, () {
      super.coinsAnimation = value;
    });
  }

  final _$coinsEndAtom = Atom(name: '_GameBase.coinsEnd');

  @override
  Function get coinsEnd {
    _$coinsEndAtom.reportRead();
    return super.coinsEnd;
  }

  @override
  set coinsEnd(Function value) {
    _$coinsEndAtom.reportWrite(value, super.coinsEnd, () {
      super.coinsEnd = value;
    });
  }

  final _$animateClockAtom = Atom(name: '_GameBase.animateClock');

  @override
  String get animateClock {
    _$animateClockAtom.reportRead();
    return super.animateClock;
  }

  @override
  set animateClock(String value) {
    _$animateClockAtom.reportWrite(value, super.animateClock, () {
      super.animateClock = value;
    });
  }

  final _$tokensListAtom = Atom(name: '_GameBase.tokensList');

  @override
  ObservableList<int> get tokensList {
    _$tokensListAtom.reportRead();
    return super.tokensList;
  }

  @override
  set tokensList(ObservableList<int> value) {
    _$tokensListAtom.reportWrite(value, super.tokensList, () {
      super.tokensList = value;
    });
  }

  final _$roundDataAtom = Atom(name: '_GameBase.roundData');

  @override
  RoundData get roundData {
    _$roundDataAtom.reportRead();
    return super.roundData;
  }

  @override
  set roundData(RoundData value) {
    _$roundDataAtom.reportWrite(value, super.roundData, () {
      super.roundData = value;
    });
  }

  final _$tokensCountAtom = Atom(name: '_GameBase.tokensCount');

  @override
  RunningNumbers get tokensCount {
    _$tokensCountAtom.reportRead();
    return super.tokensCount;
  }

  @override
  set tokensCount(RunningNumbers value) {
    _$tokensCountAtom.reportWrite(value, super.tokensCount, () {
      super.tokensCount = value;
    });
  }

  final _$walletCountAtom = Atom(name: '_GameBase.walletCount');

  @override
  RunningNumbers get walletCount {
    _$walletCountAtom.reportRead();
    return super.walletCount;
  }

  @override
  set walletCount(RunningNumbers value) {
    _$walletCountAtom.reportWrite(value, super.walletCount, () {
      super.walletCount = value;
    });
  }

  final _$pigCountAtom = Atom(name: '_GameBase.pigCount');

  @override
  RunningNumbers get pigCount {
    _$pigCountAtom.reportRead();
    return super.pigCount;
  }

  @override
  set pigCount(RunningNumbers value) {
    _$pigCountAtom.reportWrite(value, super.pigCount, () {
      super.pigCount = value;
    });
  }

  final _$onCoinsEndAnimationAsyncAction =
      AsyncAction('_GameBase.onCoinsEndAnimation');

  @override
  Future onCoinsEndAnimation(dynamic name) {
    return _$onCoinsEndAnimationAsyncAction
        .run(() => super.onCoinsEndAnimation(name));
  }

  final _$_GameBaseActionController = ActionController(name: '_GameBase');

  @override
  dynamic callElections() {
    final _$actionInfo = _$_GameBaseActionController.startAction(
        name: '_GameBase.callElections');
    try {
      return super.callElections();
    } finally {
      _$_GameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onDispose() {
    final _$actionInfo =
        _$_GameBaseActionController.startAction(name: '_GameBase.onDispose');
    try {
      return super.onDispose();
    } finally {
      _$_GameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic endRunningNumbers(Function stopRunning) {
    final _$actionInfo = _$_GameBaseActionController.startAction(
        name: '_GameBase.endRunningNumbers');
    try {
      return super.endRunningNumbers(stopRunning);
    } finally {
      _$_GameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic nextRound() {
    final _$actionInfo =
        _$_GameBaseActionController.startAction(name: '_GameBase.nextRound');
    try {
      return super.nextRound();
    } finally {
      _$_GameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic nextLevel() {
    final _$actionInfo =
        _$_GameBaseActionController.startAction(name: '_GameBase.nextLevel');
    try {
      return super.nextLevel();
    } finally {
      _$_GameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onDragToken(dynamic value) {
    final _$actionInfo =
        _$_GameBaseActionController.startAction(name: '_GameBase.onDragToken');
    try {
      return super.onDragToken(value);
    } finally {
      _$_GameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic resultWhenPlayed() {
    final _$actionInfo = _$_GameBaseActionController.startAction(
        name: '_GameBase.resultWhenPlayed');
    try {
      return super.resultWhenPlayed();
    } finally {
      _$_GameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic concludeDistribution() {
    final _$actionInfo = _$_GameBaseActionController.startAction(
        name: '_GameBase.concludeDistribution');
    try {
      return super.concludeDistribution();
    } finally {
      _$_GameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic timeOut() {
    final _$actionInfo =
        _$_GameBaseActionController.startAction(name: '_GameBase.timeOut');
    try {
      return super.timeOut();
    } finally {
      _$_GameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic callPlayersDelay() {
    final _$actionInfo = _$_GameBaseActionController.startAction(
        name: '_GameBase.callPlayersDelay');
    try {
      return super.callPlayersDelay();
    } finally {
      _$_GameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic endCoinsToPig(dynamic name) {
    final _$actionInfo = _$_GameBaseActionController.startAction(
        name: '_GameBase.endCoinsToPig');
    try {
      return super.endCoinsToPig(name);
    } finally {
      _$_GameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic remainingTokensToPig(dynamic name) {
    final _$actionInfo = _$_GameBaseActionController.startAction(
        name: '_GameBase.remainingTokensToPig');
    try {
      return super.remainingTokensToPig(name);
    } finally {
      _$_GameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic endCountEarningTokens() {
    final _$actionInfo = _$_GameBaseActionController.startAction(
        name: '_GameBase.endCountEarningTokens');
    try {
      return super.endCountEarningTokens();
    } finally {
      _$_GameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic showCoins() {
    final _$actionInfo =
        _$_GameBaseActionController.startAction(name: '_GameBase.showCoins');
    try {
      return super.showCoins();
    } finally {
      _$_GameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic pulseTheClock() {
    final _$actionInfo = _$_GameBaseActionController.startAction(
        name: '_GameBase.pulseTheClock');
    try {
      return super.pulseTheClock();
    } finally {
      _$_GameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic blinkPanel() {
    final _$actionInfo =
        _$_GameBaseActionController.startAction(name: '_GameBase.blinkPanel');
    try {
      return super.blinkPanel();
    } finally {
      _$_GameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cardKey: ${cardKey},
flareControls: ${flareControls},
startTiming: ${startTiming},
showPanelTokens: ${showPanelTokens},
coinsAnimation: ${coinsAnimation},
coinsEnd: ${coinsEnd},
animateClock: ${animateClock},
tokensList: ${tokensList},
roundData: ${roundData},
tokensCount: ${tokensCount},
walletCount: ${walletCount},
pigCount: ${pigCount}
    ''';
  }
}
