// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeiBoForwardList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForwardList _$ForwardListFromJson(Map<String, dynamic> json) => ForwardList(
      list: (json['list'] as List<dynamic>)
          .map((e) => Forward.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ForwardListToJson(ForwardList instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
