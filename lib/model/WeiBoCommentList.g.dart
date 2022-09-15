// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeiBoCommentList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentList _$CommentListFromJson(Map<String, dynamic> json) => CommentList(
      list: (json['list'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommentListToJson(CommentList instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
