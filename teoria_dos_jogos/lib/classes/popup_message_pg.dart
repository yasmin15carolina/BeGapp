import 'package:json_annotation/json_annotation.dart';
import 'package:teoria_dos_jogos/classes/myconverter.dart';
part 'popup_message_pg.g.dart';

@JsonSerializable()
class PopUpMessagePublicGoods {
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int id;
  final String message;
  final String experiment;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int round;
  @JsonKey(fromJson: MyConverter.stringToInt, toJson: MyConverter.stringFromInt)
  final int level;
  @JsonKey(
      fromJson: MyConverter.stringToBool, toJson: MyConverter.stringFromBool)
  final bool criterion;

  PopUpMessagePublicGoods(this.id, this.message, this.experiment, this.round,
      this.level, this.criterion);

  factory PopUpMessagePublicGoods.fromJson(Map<String, dynamic> json) =>
      _$PopUpMessagePublicGoodsFromJson(json);
  Map<String, dynamic> toJson() => _$PopUpMessagePublicGoodsToJson(this);
}
