// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'runningNumbers.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RunningNumbers on _RunningNumbersBase, Store {
  final _$startAtom = Atom(name: '_RunningNumbersBase.start');

  @override
  bool get start {
    _$startAtom.reportRead();
    return super.start;
  }

  @override
  set start(bool value) {
    _$startAtom.reportWrite(value, super.start, () {
      super.start = value;
    });
  }

  final _$downAtom = Atom(name: '_RunningNumbersBase.down');

  @override
  bool get down {
    _$downAtom.reportRead();
    return super.down;
  }

  @override
  set down(bool value) {
    _$downAtom.reportWrite(value, super.down, () {
      super.down = value;
    });
  }

  final _$inicialAtom = Atom(name: '_RunningNumbersBase.inicial');

  @override
  int get inicial {
    _$inicialAtom.reportRead();
    return super.inicial;
  }

  @override
  set inicial(int value) {
    _$inicialAtom.reportWrite(value, super.inicial, () {
      super.inicial = value;
    });
  }

  final _$diferenceAtom = Atom(name: '_RunningNumbersBase.diference');

  @override
  int get diference {
    _$diferenceAtom.reportRead();
    return super.diference;
  }

  @override
  set diference(int value) {
    _$diferenceAtom.reportWrite(value, super.diference, () {
      super.diference = value;
    });
  }

  final _$factorAtom = Atom(name: '_RunningNumbersBase.factor');

  @override
  int get factor {
    _$factorAtom.reportRead();
    return super.factor;
  }

  @override
  set factor(int value) {
    _$factorAtom.reportWrite(value, super.factor, () {
      super.factor = value;
    });
  }

  final _$_RunningNumbersBaseActionController =
      ActionController(name: '_RunningNumbersBase');

  @override
  dynamic startCountUp() {
    final _$actionInfo = _$_RunningNumbersBaseActionController.startAction(
        name: '_RunningNumbersBase.startCountUp');
    try {
      return super.startCountUp();
    } finally {
      _$_RunningNumbersBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic startCountDown() {
    final _$actionInfo = _$_RunningNumbersBaseActionController.startAction(
        name: '_RunningNumbersBase.startCountDown');
    try {
      return super.startCountDown();
    } finally {
      _$_RunningNumbersBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic stop() {
    final _$actionInfo = _$_RunningNumbersBaseActionController.startAction(
        name: '_RunningNumbersBase.stop');
    try {
      return super.stop();
    } finally {
      _$_RunningNumbersBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setValues(int inicial, int diference) {
    final _$actionInfo = _$_RunningNumbersBaseActionController.startAction(
        name: '_RunningNumbersBase.setValues');
    try {
      return super.setValues(inicial, diference);
    } finally {
      _$_RunningNumbersBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
start: ${start},
down: ${down},
inicial: ${inicial},
diference: ${diference},
factor: ${factor}
    ''';
  }
}
