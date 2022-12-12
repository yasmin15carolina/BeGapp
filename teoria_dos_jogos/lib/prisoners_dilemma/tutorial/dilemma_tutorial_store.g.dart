// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dilemma_tutorial_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PrisonerDilemmaTutorial on _PrisonerDilemmaTutorialBase, Store {
  final _$startTimingAtom =
      Atom(name: '_PrisonerDilemmaTutorialBase.startTiming');

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
      Atom(name: '_PrisonerDilemmaTutorialBase.animateClock');

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
      Atom(name: '_PrisonerDilemmaTutorialBase.yourChoiceTarget');

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
      Atom(name: '_PrisonerDilemmaTutorialBase.otherChoiceTarget');

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

  final _$draggableAtom = Atom(name: '_PrisonerDilemmaTutorialBase.draggable');

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
      Atom(name: '_PrisonerDilemmaTutorialBase.oponentChoice');

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

  final _$userChoiceAtom =
      Atom(name: '_PrisonerDilemmaTutorialBase.userChoice');

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
      Atom(name: '_PrisonerDilemmaTutorialBase.dilemmaRound');

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
      Atom(name: '_PrisonerDilemmaTutorialBase.otherPlayerDelay');

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

  final _$waitDelayAtom = Atom(name: '_PrisonerDilemmaTutorialBase.waitDelay');

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

  final _$computeChoiceAsyncAction =
      AsyncAction('_PrisonerDilemmaTutorialBase.computeChoice');

  @override
  Future computeChoice() {
    return _$computeChoiceAsyncAction.run(() => super.computeChoice());
  }

  final _$sendDataToDatabaseAsyncAction =
      AsyncAction('_PrisonerDilemmaTutorialBase.sendDataToDatabase');

  @override
  Future sendDataToDatabase() {
    return _$sendDataToDatabaseAsyncAction
        .run(() => super.sendDataToDatabase());
  }

  final _$_PrisonerDilemmaTutorialBaseActionController =
      ActionController(name: '_PrisonerDilemmaTutorialBase');

  @override
  dynamic toggleYourPoints() {
    final _$actionInfo = _$_PrisonerDilemmaTutorialBaseActionController
        .startAction(name: '_PrisonerDilemmaTutorialBase.toggleYourPoints');
    try {
      return super.toggleYourPoints();
    } finally {
      _$_PrisonerDilemmaTutorialBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic toggleOtherPoints() {
    final _$actionInfo = _$_PrisonerDilemmaTutorialBaseActionController
        .startAction(name: '_PrisonerDilemmaTutorialBase.toggleOtherPoints');
    try {
      return super.toggleOtherPoints();
    } finally {
      _$_PrisonerDilemmaTutorialBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onDragCard(dynamic value) {
    final _$actionInfo = _$_PrisonerDilemmaTutorialBaseActionController
        .startAction(name: '_PrisonerDilemmaTutorialBase.onDragCard');
    try {
      return super.onDragCard(value);
    } finally {
      _$_PrisonerDilemmaTutorialBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic showResult() {
    final _$actionInfo = _$_PrisonerDilemmaTutorialBaseActionController
        .startAction(name: '_PrisonerDilemmaTutorialBase.showResult');
    try {
      return super.showResult();
    } finally {
      _$_PrisonerDilemmaTutorialBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic nextRound() {
    final _$actionInfo = _$_PrisonerDilemmaTutorialBaseActionController
        .startAction(name: '_PrisonerDilemmaTutorialBase.nextRound');
    try {
      return super.nextRound();
    } finally {
      _$_PrisonerDilemmaTutorialBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic timeOut() {
    final _$actionInfo = _$_PrisonerDilemmaTutorialBaseActionController
        .startAction(name: '_PrisonerDilemmaTutorialBase.timeOut');
    try {
      return super.timeOut();
    } finally {
      _$_PrisonerDilemmaTutorialBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic showGraphic() {
    final _$actionInfo = _$_PrisonerDilemmaTutorialBaseActionController
        .startAction(name: '_PrisonerDilemmaTutorialBase.showGraphic');
    try {
      return super.showGraphic();
    } finally {
      _$_PrisonerDilemmaTutorialBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onEndCardAnimation(Color color) {
    final _$actionInfo = _$_PrisonerDilemmaTutorialBaseActionController
        .startAction(name: '_PrisonerDilemmaTutorialBase.onEndCardAnimation');
    try {
      return super.onEndCardAnimation(color);
    } finally {
      _$_PrisonerDilemmaTutorialBaseActionController.endAction(_$actionInfo);
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
