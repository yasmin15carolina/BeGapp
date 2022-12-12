// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prisoner_dilemma_game_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PrisonerDilemmaGame on _PrisonerDilemmaGameBase, Store {
  final _$startTimingAtom = Atom(name: '_PrisonerDilemmaGameBase.startTiming');

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

  final _$animateClockAtom =
      Atom(name: '_PrisonerDilemmaGameBase.animateClock');

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

  final _$yourChoiceTargetAtom =
      Atom(name: '_PrisonerDilemmaGameBase.yourChoiceTarget');

  @override
  Widget get yourChoiceTarget {
    _$yourChoiceTargetAtom.reportRead();
    return super.yourChoiceTarget;
  }

  @override
  set yourChoiceTarget(Widget value) {
    _$yourChoiceTargetAtom.reportWrite(value, super.yourChoiceTarget, () {
      super.yourChoiceTarget = value;
    });
  }

  final _$otherChoiceTargetAtom =
      Atom(name: '_PrisonerDilemmaGameBase.otherChoiceTarget');

  @override
  Widget get otherChoiceTarget {
    _$otherChoiceTargetAtom.reportRead();
    return super.otherChoiceTarget;
  }

  @override
  set otherChoiceTarget(Widget value) {
    _$otherChoiceTargetAtom.reportWrite(value, super.otherChoiceTarget, () {
      super.otherChoiceTarget = value;
    });
  }

  final _$draggableAtom = Atom(name: '_PrisonerDilemmaGameBase.draggable');

  @override
  bool get draggable {
    _$draggableAtom.reportRead();
    return super.draggable;
  }

  @override
  set draggable(bool value) {
    _$draggableAtom.reportWrite(value, super.draggable, () {
      super.draggable = value;
    });
  }

  final _$oponentChoiceAtom =
      Atom(name: '_PrisonerDilemmaGameBase.oponentChoice');

  @override
  int get oponentChoice {
    _$oponentChoiceAtom.reportRead();
    return super.oponentChoice;
  }

  @override
  set oponentChoice(int value) {
    _$oponentChoiceAtom.reportWrite(value, super.oponentChoice, () {
      super.oponentChoice = value;
    });
  }

  final _$userChoiceAtom = Atom(name: '_PrisonerDilemmaGameBase.userChoice');

  @override
  int get userChoice {
    _$userChoiceAtom.reportRead();
    return super.userChoice;
  }

  @override
  set userChoice(int value) {
    _$userChoiceAtom.reportWrite(value, super.userChoice, () {
      super.userChoice = value;
    });
  }

  final _$dilemmaRoundAtom =
      Atom(name: '_PrisonerDilemmaGameBase.dilemmaRound');

  @override
  DilemmaRound get dilemmaRound {
    _$dilemmaRoundAtom.reportRead();
    return super.dilemmaRound;
  }

  @override
  set dilemmaRound(DilemmaRound value) {
    _$dilemmaRoundAtom.reportWrite(value, super.dilemmaRound, () {
      super.dilemmaRound = value;
    });
  }

  final _$otherPlayerDelayAtom =
      Atom(name: '_PrisonerDilemmaGameBase.otherPlayerDelay');

  @override
  int get otherPlayerDelay {
    _$otherPlayerDelayAtom.reportRead();
    return super.otherPlayerDelay;
  }

  @override
  set otherPlayerDelay(int value) {
    _$otherPlayerDelayAtom.reportWrite(value, super.otherPlayerDelay, () {
      super.otherPlayerDelay = value;
    });
  }

  final _$waitDelayAtom = Atom(name: '_PrisonerDilemmaGameBase.waitDelay');

  @override
  int get waitDelay {
    _$waitDelayAtom.reportRead();
    return super.waitDelay;
  }

  @override
  set waitDelay(int value) {
    _$waitDelayAtom.reportWrite(value, super.waitDelay, () {
      super.waitDelay = value;
    });
  }

  final _$executeAlgorithmAsyncAction =
      AsyncAction('_PrisonerDilemmaGameBase.executeAlgorithm');

  @override
  Future executeAlgorithm() {
    return _$executeAlgorithmAsyncAction.run(() => super.executeAlgorithm());
  }

  final _$sendDataToDatabaseAsyncAction =
      AsyncAction('_PrisonerDilemmaGameBase.sendDataToDatabase');

  @override
  Future sendDataToDatabase() {
    return _$sendDataToDatabaseAsyncAction
        .run(() => super.sendDataToDatabase());
  }

  final _$_PrisonerDilemmaGameBaseActionController =
      ActionController(name: '_PrisonerDilemmaGameBase');

  @override
  dynamic toggleYourPoints() {
    final _$actionInfo = _$_PrisonerDilemmaGameBaseActionController.startAction(
        name: '_PrisonerDilemmaGameBase.toggleYourPoints');
    try {
      return super.toggleYourPoints();
    } finally {
      _$_PrisonerDilemmaGameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic toggleOtherPoints() {
    final _$actionInfo = _$_PrisonerDilemmaGameBaseActionController.startAction(
        name: '_PrisonerDilemmaGameBase.toggleOtherPoints');
    try {
      return super.toggleOtherPoints();
    } finally {
      _$_PrisonerDilemmaGameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onDragCard(dynamic value) {
    final _$actionInfo = _$_PrisonerDilemmaGameBaseActionController.startAction(
        name: '_PrisonerDilemmaGameBase.onDragCard');
    try {
      return super.onDragCard(value);
    } finally {
      _$_PrisonerDilemmaGameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic callPlayersDelay() {
    final _$actionInfo = _$_PrisonerDilemmaGameBaseActionController.startAction(
        name: '_PrisonerDilemmaGameBase.callPlayersDelay');
    try {
      return super.callPlayersDelay();
    } finally {
      _$_PrisonerDilemmaGameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic checkStability() {
    final _$actionInfo = _$_PrisonerDilemmaGameBaseActionController.startAction(
        name: '_PrisonerDilemmaGameBase.checkStability');
    try {
      return super.checkStability();
    } finally {
      _$_PrisonerDilemmaGameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic showResult() {
    final _$actionInfo = _$_PrisonerDilemmaGameBaseActionController.startAction(
        name: '_PrisonerDilemmaGameBase.showResult');
    try {
      return super.showResult();
    } finally {
      _$_PrisonerDilemmaGameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic registerRound() {
    final _$actionInfo = _$_PrisonerDilemmaGameBaseActionController.startAction(
        name: '_PrisonerDilemmaGameBase.registerRound');
    try {
      return super.registerRound();
    } finally {
      _$_PrisonerDilemmaGameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic nextRound() {
    final _$actionInfo = _$_PrisonerDilemmaGameBaseActionController.startAction(
        name: '_PrisonerDilemmaGameBase.nextRound');
    try {
      return super.nextRound();
    } finally {
      _$_PrisonerDilemmaGameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic timeOut() {
    final _$actionInfo = _$_PrisonerDilemmaGameBaseActionController.startAction(
        name: '_PrisonerDilemmaGameBase.timeOut');
    try {
      return super.timeOut();
    } finally {
      _$_PrisonerDilemmaGameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic showGraphic() {
    final _$actionInfo = _$_PrisonerDilemmaGameBaseActionController.startAction(
        name: '_PrisonerDilemmaGameBase.showGraphic');
    try {
      return super.showGraphic();
    } finally {
      _$_PrisonerDilemmaGameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onEndCardAnimation(Color color) {
    final _$actionInfo = _$_PrisonerDilemmaGameBaseActionController.startAction(
        name: '_PrisonerDilemmaGameBase.onEndCardAnimation');
    try {
      return super.onEndCardAnimation(color);
    } finally {
      _$_PrisonerDilemmaGameBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
startTiming: ${startTiming},
animateClock: ${animateClock},
yourChoiceTarget: ${yourChoiceTarget},
otherChoiceTarget: ${otherChoiceTarget},
draggable: ${draggable},
oponentChoice: ${oponentChoice},
userChoice: ${userChoice},
dilemmaRound: ${dilemmaRound},
otherPlayerDelay: ${otherPlayerDelay},
waitDelay: ${waitDelay}
    ''';
  }
}
