import 'package:json_annotation/json_annotation.dart';
import 'package:teoria_dos_jogos/classes/myconverter.dart';
part 'publicGoodsVariables.g.dart';

@JsonSerializable()
class PublicGoodsVariables {
  String adminId; //id do admin criador do experimento
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  int publicConfig; // se essa configuração de experimento é publica
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  int publicData; //se os resultados do experimento são publicos
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  late int id;
  final String key;
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  bool onlyContribution; //se o exprimento possui apenas a fase de contribuição

  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int maxTokens; //maximo de fichas para investir
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int time; //tempo do round
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int factor; //fator de multiplicação do dinheiro
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int maxTrys;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int realPlayers; //numero de jogadores reais alem do usuario
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int notRealPlayers; //numero de jogadores simulados alem do usuario
  final String name; //nome da configuração do jogo
  final String descri; //descrição experimento
  final DateTime start;
  final DateTime end;

  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  final bool showRounds;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int timeDistribution;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int timeElection;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int contributionsVariation;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int distributionVariation;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int unfairDistribution;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int stable;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int limitVotes;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int waitingRounds;

  @JsonKey(fromJson: MyConverter.ruleToInt, toJson: MyConverter.ruleFromInt)
  final int electionRule;

  PublicGoodsVariables(
      this.adminId,
      this.publicConfig,
      this.publicData,
      this.key,
      this.maxTokens,
      this.time,
      this.factor,
      this.maxTrys,
      this.realPlayers,
      this.notRealPlayers,
      this.name,
      this.descri,
      this.start,
      this.end,
      this.showRounds,
      this.onlyContribution,
      this.timeDistribution,
      this.timeElection,
      this.contributionsVariation,
      this.distributionVariation,
      this.unfairDistribution,
      this.stable,
      this.limitVotes,
      this.waitingRounds,
      this.electionRule);

  factory PublicGoodsVariables.fromJson(Map<String, dynamic> json) =>
      _$PublicGoodsVariablesFromJson(json);
  Map<String, dynamic> toJson() => _$PublicGoodsVariablesToJson(this);

  static int getRule(String rule) {
    switch (rule) {
      case "intermittent election disabled":
        return 1;
      case "intermittent election enabled":
        return 2;
      case "recurring election disabled":
        return 3;
      case "recurring election enabled":
        return 4;
      default:
        return 0;
    }
  }

  maxWalletValue() {
    double max;
    int maxRib;
    double maxEarning;
    maxRib = (notRealPlayers + 1) * maxTokens * factor;
    maxEarning = maxRib / (notRealPlayers + 1);
    max = maxEarning * maxTrys;

    return max;
  }
}
