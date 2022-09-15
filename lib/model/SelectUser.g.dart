// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SelectUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectUser _$SelectUserFromJson(Map<String, dynamic> json) => SelectUser(
      name: json['name'] as String,
      tagIndex: json['tagIndex'] as String,
      namePinyin: json['namePinyin'] as String,
    )..isShowSuspension = json['isShowSuspension'] as bool;

Map<String, dynamic> _$SelectUserToJson(SelectUser instance) =>
    <String, dynamic>{
      'isShowSuspension': instance.isShowSuspension,
      'name': instance.name,
      'tagIndex': instance.tagIndex,
      'namePinyin': instance.namePinyin,
    };
