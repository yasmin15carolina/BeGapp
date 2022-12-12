import 'package:json_annotation/json_annotation.dart';
import 'package:teoria_dos_jogos/classes/myconverter.dart';
part 'dilemmaVariables.g.dart';

@JsonSerializable()
class DilemmaVariables {
  String? adminId; //id do admin criador do experimento
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int publicConfig; // se essa configuração de experimento é publica
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int publicData; //se os resultados do experimento são publicos
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int id;
  final String? key;
  final String? algorithm;
  final String? secondAlgorithm;
  final String? gameName;
  String? dependentVariable;
  String? independentVariable;
  String? formLink;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int bothCooperate;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int bothDefect;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int cooperateLoses;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int defectWin;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int roundsNumber;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int maxTime;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int stable;
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  final bool showRounds;
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  final bool showClock;
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  final bool showYourPoints;
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  final bool showOtherPoints;
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  final bool yourPointsRand;
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  final bool otherPointsRand;
  final DateTime start;
  final DateTime end;

  DilemmaVariables(
    this.key,
    this.algorithm,
    this.secondAlgorithm,
    this.dependentVariable,
    this.independentVariable,
    this.gameName,
    this.bothCooperate,
    this.bothDefect,
    this.cooperateLoses,
    this.defectWin,
    this.roundsNumber,
    this.maxTime,
    this.stable,
    this.showRounds,
    this.showClock,
    this.showYourPoints,
    this.showOtherPoints,
    this.yourPointsRand,
    this.otherPointsRand,
    this.start,
    this.end,
    this.formLink,
  );

  factory DilemmaVariables.fromJson(Map<String, dynamic> json) =>
      _$DilemmaVariablesFromJson(json);
  Map<String, dynamic> toJson() => _$DilemmaVariablesToJson(this);
}
