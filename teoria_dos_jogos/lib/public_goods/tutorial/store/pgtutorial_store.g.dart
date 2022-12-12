// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pgtutorial_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TutorialGameStore on _TutorialGameStoreBase, Store {
  final _$cardKeyAtom = Atom(name: '_TutorialGameStoreBase.cardKey');

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

  final _$flareControlsAtom =
      Atom(name: '_TutorialGameStoreBase.flareControls');

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

  final _$startTimingAtom = Atom(name: '_TutorialGameStoreBase.startTiming');

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

  final _$showPanelTokensAtom =
      Atom(name: '_TutorialGameStoreBase.showPanelTokens');

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

  final _$coinsAnimationAtom =
      Atom(name: '_TutorialGameStoreBase.coinsAnimation');

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

  final _$animateClockAtom = Atom(name: '_TutorialGameStoreBase.animateClock');

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

  final _$tokensListAtom = Atom(name: '_TutorialGameStoreBase.tokensList');

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

  final _$roundDataAtom = Atom(name: '_TutorialGameStoreBase.roundData');

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

  final _$tokensCountAtom = Atom(name: '_TutorialGameStoreBase.tokensCount');

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

  final _$walletCountAtom = Atom(name: '_TutorialGameStoreBase.walletCount');

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

  final _$pigCountAtom = Atom(name: '_TutorialGameStoreBase.pigCount');

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

  final _$coinsEndAtom = Atom(name: '_TutorialGameStoreBase.coinsEnd');

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

  final _$onCoinsEndAnimationAsyncAction =
      AsyncAction('_TutorialGameStoreBase.onCoinsEndAnimation');

  @override
  Future onCoinsEndAnimation(dynamic name) {
    return _$onCoinsEndAnimationAsyncAction
        .run(() => super.onCoinsEndAnimation(name));
  }

  final _$_TutorialGameStoreBaseActionController =
      ActionController(name: '_TutorialGameStoreBase');

  @override
  dynamic nextLevel() {
    final _$actionInfo = _$_TutorialGameStoreBaseActionController.startAction(
        name: '_TutorialGameStoreBase.nextLevel');
    try {
      return super.nextLevel();
    } finally {
      _$_TutorialGameStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic callElections() {
    final _$actionInfo = _$_TutorialGameStoreBaseActionController.startAction(
        name: '_TutorialGameStoreBase.callElections');
    try {
      return super.callElections();
    } finally {
      _$_TutorialGameStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onDispose() {
    final _$actionInfo = _$_TutorialGameStoreBaseActionController.startAction(
        name: '_TutorialGameStoreBase.onDispose');
    try {
      return super.onDispose();
    } finally {
      _$_TutorialGameStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic endRunningNumbers(Function stopRunning) {
    final _$actionInfo = _$_TutorialGameStoreBaseActionController.startAction(
        name: '_TutorialGameStoreBase.endRunningNumbers');
    try {
      return super.endRunningNumbers(stopRunning);
    } finally {
      _$_TutorialGameStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic nextRound() {
    final _$actionInfo = _$_TutorialGameStoreBaseActionController.startAction(
        name: '_TutorialGameStoreBase.nextRound');
    try {
      return super.nextRound();
    } finally {
      _$_TutorialGameStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onDragToken(dynamic value) {
    final _$actionInfo = _$_TutorialGameStoreBaseActionController.startAction(
        name: '_TutorialGameStoreBase.onDragToken');
    try {
      return super.onDragToken(value);
    } finally {
      _$_TutorialGameStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic resultWhenPlayed() {
    final _$actionInfo = _$_TutorialGameStoreBaseActionController.startAction(
        name: '_TutorialGameStoreBase.resultWhenPlayed');
    try {
      return super.resultWhenPlayed();
    } finally {
      _$_TutorialGameStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic concludeDistribution() {
    final _$actionInfo = _$_TutorialGameStoreBaseActionController.startAction(
        name: '_TutorialGameStoreBase.concludeDistribution');
    try {
      return super.concludeDistribution();
    } finally {
      _$_TutorialGameStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic timeOut() {
    final _$actionInfo = _$_TutorialGameStoreBaseActionController.startAction(
        name: '_TutorialGameStoreBase.timeOut');
    try {
      return super.timeOut();
    } finally {
      _$_TutorialGameStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic callPlayersDelay() {
    final _$actionInfo = _$_TutorialGameStoreBaseActionController.startAction(
        name: '_TutorialGameStoreBase.callPlayersDelay');
    try {
      return super.callPlayersDelay();
    } finally {
      _$_TutorialGameStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic endCoinsToPig(dynamic name) {
    final _$actionInfo = _$_TutorialGameStoreBaseActionController.startAction(
        name: '_TutorialGameStoreBase.endCoinsToPig');
    try {
      return super.endCoinsToPig(name);
    } finally {
      _$_TutorialGameStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic remainingTokensToPig(dynamic name) {
    final _$actionInfo = _$_TutorialGameStoreBaseActionController.startAction(
        name: '_TutorialGameStoreBase.remainingTokensToPig');
    try {
      return super.remainingTokensToPig(name);
    } finally {
      _$_TutorialGameStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic endCountEarningTokens() {
    final _$actionInfo = _$_TutorialGameStoreBaseActionController.startAction(
        name: '_TutorialGameStoreBase.endCountEarningTokens');
    try {
      return super.endCountEarningTokens();
    } finally {
      _$_TutorialGameStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic showCoins() {
    final _$actionInfo = _$_TutorialGameStoreBaseActionController.startAction(
        name: '_TutorialGameStoreBase.showCoins');
    try {
      return super.showCoins();
    } finally {
      _$_TutorialGameStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic pulseTheClock() {
    final _$actionInfo = _$_TutorialGameStoreBaseActionController.startAction(
        name: '_TutorialGameStoreBase.pulseTheClock');
    try {
      return super.pulseTheClock();
    } finally {
      _$_TutorialGameStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic blinkPanel() {
    final _$actionInfo = _$_TutorialGameStoreBaseActionController.startAction(
        name: '_TutorialGameStoreBase.blinkPanel');
    try {
      return super.blinkPanel();
    } finally {
      _$_TutorialGameStoreBaseActionController.endAction(_$actionInfo);
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
animateClock: ${animateClock},
tokensList: ${tokensList},
roundData: ${roundData},
tokensCount: ${tokensCount},
walletCount: ${walletCount},
pigCount: ${pigCount},
coinsEnd: ${coinsEnd}
    ''';
  }
}
