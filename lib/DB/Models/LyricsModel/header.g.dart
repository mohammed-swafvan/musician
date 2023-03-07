// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'header.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Header _$HeaderFromJson(Map<String, dynamic> json) => Header(
      statusCode: json['status_code'] as int?,
      executeTime: (json['execute_time'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$HeaderToJson(Header instance) => <String, dynamic>{
      'status_code': instance.statusCode,
      'execute_time': instance.executeTime,
    };
