// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeiBoTopic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeiBoTopic _$WeiBoTopicFromJson(Map<String, dynamic> json) => WeiBoTopic(
      topicid: json['topicid'] as String,
      topictype: json['topictype'] as String,
      topicdesc: json['topicdesc'] as String,
      topicread: json['topicread'] as String,
      topicdiscuss: json['topicdiscuss'] as String,
      topichost: json['topichost'] as String,
      topicattitude: json['topicattitude'] as String,
      topicimg: json['topicimg'] as String,
    );

Map<String, dynamic> _$WeiBoTopicToJson(WeiBoTopic instance) =>
    <String, dynamic>{
      'topicid': instance.topicid,
      'topictype': instance.topictype,
      'topicdesc': instance.topicdesc,
      'topicread': instance.topicread,
      'topicdiscuss': instance.topicdiscuss,
      'topichost': instance.topichost,
      'topicattitude': instance.topicattitude,
      'topicimg': instance.topicimg,
    };
