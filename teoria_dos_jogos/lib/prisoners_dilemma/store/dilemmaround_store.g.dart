// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dilemmaround_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DilemmaRound on _DilemmaRoundBase, Store {
  final _$roundAtom = Atom(name: '_DilemmaRoundBase.round');

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

  final _$seeYourPointsAtom = Atom(name: '_DilemmaRoundBase.seeYourPoints');

  @override
  bool get seeYourPoints {
    _$seeYourPointsAtom.reportRead();
    return super.seeYourPoints;
  }

  @override
  set seeYourPoints(bool value) {
    _$seeYourPointsAtom.reportWrite(value, super.seeYourPoints, () {
      super.seeYourPoints = value;
    });
  }

  final _$seeOtherPointsAtom = Atom(name: '_DilemmaRoundBase.seeOtherPoints');

  @override
  bool get seeOtherPoints {
    _$seeOtherPointsAtom.reportRead();
    return super.seeOtherPoints;
  }

  @override
  set seeOtherPoints(bool value) {
    _$seeOtherPointsAtom.reportWrite(value, super.seeOtherPoints, () {
      super.seeOtherPoints = value;
    });
  }

  final _$yourRandAtom = Atom(name: '_DilemmaRoundBase.yourRand');

  @override
  bool get yourRand {
    _$yourRandAtom.reportRead();
    return super.yourRand;
  }

  @override
  set yourRand(bool value) {
    _$yourRandAtom.reportWrite(value, super.yourRand, () {
      super.yourRand = value;
    });
  }

  final _$otherRandAtom = Atom(name: '_DilemmaRoundBase.otherRand');

  @override
  bool get otherRand {
    _$otherRandAtom.reportRead();
    return super.otherRand;
  }

  @override
  set otherRand(bool value) {
    _$otherRandAtom.reportWrite(value, super.otherRand, () {
      super.otherRand = value;
    });
  }

  final _$resultAtom = Atom(name: '_DilemmaRoundBase.result');

  @override
  String get result {
    _$resultAtom.reportRead();
    return super.result;
  }

  @override
  set result(String value) {
    _$resultAtom.reportWrite(value, super.result, () {
      super.result = value;
    });
  }

  final _$_DilemmaRoundBaseActionController =
      ActionController(name: '_DilemmaRoundBase');

  @override
  dynamic calculateResult(DilemmaVariables dilemmaVariables) {
    final _$actionInfo = _$_DilemmaRoundBaseActionController.startAction(
        name: '_DilemmaRoundBase.calculateResult');
    try {
      return super.calculateResult(dilemmaVariables);
    } finally {
      _$_DilemmaRoundBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
round: ${round},
seeYourPoints: ${seeYourPoints},
seeOtherPoints: ${seeOtherPoints},
yourRand: ${yourRand},
otherRand: ${otherRand},
result: ${result}
    ''';
  }
}
