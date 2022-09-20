// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OtherUserModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtherUser _$OtherUserFromJson(Map<String, dynamic> json) => OtherUser(
      id: json['id'] as String,
       nick: json['nick'] as String,
      headurl: json['headurl'] as String,
      decs: json['decs'] as String,
      gender: json['gender'] as String,
      followCount: json['followCount'] as String,
      fanCount: json['fanCount'] as String,
      ismember: json['ismember'] as int,
      isvertify: json['isvertify'] as int,
      relation: json['relation'] as int,
      createtime: json['createtime'] as int,
    );

Map<String, dynamic> _$OtherUserToJson(OtherUser instance) => <String, dynamic>{
      'id': instance.id,
       'nick': instance.nick,
      'headurl': instance.headurl,
      'decs': instance.decs,
      'gender': instance.gender,
      'followCount': instance.followCount,
      'fanCount': instance.fanCount,
      'ismember': instance.ismember,
      'isvertify': instance.isvertify,
      'relation': instance.relation,
      'createtime': instance.createtime,
    };
