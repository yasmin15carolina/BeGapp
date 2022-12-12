import 'package:json_annotation/json_annotation.dart';
import 'package:teoria_dos_jogos/classes/myconverter.dart';
part 'popup_message_pd.g.dart';

@JsonSerializable()
class PopUpMessagePrisonersDilemma {
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int id;
  final String message;
  final String experiment;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int round;

  PopUpMessagePrisonersDilemma(
    this.id,
    this.message,
    this.experiment,
    this.round,
  );

  factory PopUpMessagePrisonersDilemma.fromJson(Map<String, dynamic> json) =>
      _$PopUpMessagePrisonersDilemmaFromJson(json);
  Map<String, dynamic> toJson() => _$PopUpMessagePrisonersDilemmaToJson(this);
}
