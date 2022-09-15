// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeiboAtUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeiboAtUsers _$WeiboAtUsersFromJson(Map<String, dynamic> json) => WeiboAtUsers(
      hotusers: (json['hotusers'] as List<dynamic>)
          .map((e) => WeiboAtUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      normalusers: (json['normalusers'] as List<dynamic>)
          .map((e) => WeiboAtUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeiboAtUsersToJson(WeiboAtUsers instance) =>
    <String, dynamic>{
      'hotusers': instance.hotusers,
      'normalusers': instance.normalusers,
    };

WeiboAtUser _$WeiboAtUserFromJson(Map<String, dynamic> json) => WeiboAtUser(
      id: json['id'] as String,
      nick: json['nick'] as String,
      headurl: json['headurl'] as String,
      decs: json['decs'] as String,
      gender: json['gender'] as String,
      followCount: json['followCount'] as String,
      fanCount: json['fanCount'] as String,
    )
      ..isShowSuspension = json['isShowSuspension'] as bool
      ..tagIndex = json['tagIndex'] as String?
      ..namePinyin = json['namePinyin'] as String?;

Map<String, dynamic> _$WeiboAtUserToJson(WeiboAtUser instance) =>
    <String, dynamic>{
      'isShowSuspension': instance.isShowSuspension,
      'id': instance.id,
      'nick': instance.nick,
      'headurl': instance.headurl,
      'decs': instance.decs,
      'gender': instance.gender,
      'followCount': instance.followCount,
      'fanCount': instance.fanCount,
      'tagIndex': instance.tagIndex,
      'namePinyin': instance.namePinyin,
    };
