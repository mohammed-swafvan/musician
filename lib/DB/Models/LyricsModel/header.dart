import 'package:json_annotation/json_annotation.dart';
part 'header.g.dart';

@JsonSerializable()
class Header {
  @JsonKey(name: 'status_code')
  int? statusCode;
  @JsonKey(name: 'execute_time')
  double? executeTime;

  Header({this.statusCode, this.executeTime});

  factory Header.fromJson(Map<String, dynamic> json) {
    return _$HeaderFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HeaderToJson(this);
}