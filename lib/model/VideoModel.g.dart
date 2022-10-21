// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VideoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) => VideoModel(
      id: json['id'] as int,
      coverimg: json['coverimg'] as String,
      videotime: json['videotime'] as int,
      playnum: json['playnum']  ,
      userid: json['userid'] as int,
      tag: json['tag'] as dynamic,
      recommengstr: json['recommengstr'] as String,
      type: json['type'] as int,
      introduce: json['introduce'] as String,
      createtime: json['createtime'] as int,
      username: json['username'] as String,
      userheadurl: json['userheadurl'] as String,
      userisvertify: json['userisvertify'] as int,
      zannum: json['zannum'] as int,
      videourl: json['videourl'] as String,
      userfancount: json['userfancount'] ,
      userdesc: json['userdesc'] as String,
    );

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'coverimg': instance.coverimg,
      'videotime': instance.videotime,
      'playnum': instance.playnum,
      'userid': instance.userid,
      'tag': instance.tag,
      'recommengstr': instance.recommengstr,
      'type': instance.type,
      'introduce': instance.introduce,
      'createtime': instance.createtime,
      'username': instance.username,
      'userheadurl': instance.userheadurl,
      'userisvertify': instance.userisvertify,
      'zannum': instance.zannum,
      'videourl': instance.videourl,
      'userfancount': instance.userfancount,
      'userdesc': instance.userdesc,
    };
