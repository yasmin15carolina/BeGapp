import 'package:json_annotation/json_annotation.dart';
part 'maxLength.g.dart';

@JsonSerializable()
class MaxLength {
  @JsonKey(fromJson: _stringToInt, toJson: _stringFromInt)
  final int? CHARACTER_MAXIMUM_LENGTH;

  MaxLength(this.CHARACTER_MAXIMUM_LENGTH);

  factory MaxLength.fromJson(Map<String, dynamic> json) =>
      _$MaxLengthFromJson(json);
  Map<String, dynamic> toJson() => _$MaxLengthToJson(this);

  static int _stringToInt(String? number) =>
      number == null ? null as int : int.parse(number);

  static String _stringFromInt(int? number) => number.toString();
}
