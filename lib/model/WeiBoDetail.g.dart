// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeiBoDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeiBoDetail _$WeiBoDetailFromJson(Map<String, dynamic> json) => WeiBoDetail(
      comment: (json['comment'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      forward: (json['forward'] as List<dynamic>)
          .map((e) => Forward.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeiBoDetailToJson(WeiBoDetail instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'forward': instance.forward,
    };

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      commentid: json['commentid'] as String,
      weiboid: json['weiboid'] as String,
      fromuid: json['fromuid'] as String,
      fromuname: json['fromuname'] as String,
      fromhead: json['fromhead'] as String,
      fromuserismember: json['fromuserismember'] as int,
      fromuserisvertify: json['fromuserisvertify'] as int,
      content: json['content'] as String,
      createtime: json['createtime'] as int,
      commentreply: (json['commentreply'] as List<dynamic>)
          .map((e) => Commentreply.fromJson(e as Map<String, dynamic>))
          .toList(),
      commentreplynum: json['commentreplynum'] as int,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'commentid': instance.commentid,
      'weiboid': instance.weiboid,
      'fromuid': instance.fromuid,
      'fromuname': instance.fromuname,
      'fromhead': instance.fromhead,
      'fromuserismember': instance.fromuserismember,
      'fromuserisvertify': instance.fromuserisvertify,
      'content': instance.content,
      'createtime': instance.createtime,
      'commentreply': instance.commentreply,
      'commentreplynum': instance.commentreplynum,
    };

Commentreply _$CommentreplyFromJson(Map<String, dynamic> json) => Commentreply(
      commentid: json['commentid'] as String,
      crid: json['crid'] as String,
      fromuid: json['fromuid'] as String,
      fromuname: json['fromuname'] as String,
      fromhead: json['fromhead'] as String,
      fromuserismember: json['fromuserismember'] as int,
      fromuserisvertify: json['fromuserisvertify'] as int,
      content: json['content'] as String,
      createtime: json['createtime'] as int,
    );

Map<String, dynamic> _$CommentreplyToJson(Commentreply instance) =>
    <String, dynamic>{
      'commentid': instance.commentid,
      'crid': instance.crid,
      'fromuid': instance.fromuid,
      'fromuname': instance.fromuname,
      'fromhead': instance.fromhead,
      'fromuserismember': instance.fromuserismember,
      'fromuserisvertify': instance.fromuserisvertify,
      'content': instance.content,
      'createtime': instance.createtime,
    };

Forward _$ForwardFromJson(Map<String, dynamic> json) => Forward(
      zfid: json['zfid'] as String,
      fromuid: json['fromuid'] as String,
      fromuname: json['fromuname'] as String,
      fromhead: json['fromhead'] as String,
      fromuserismember: json['fromuserismember'] as int,
      fromuserisvertify: json['fromuserisvertify'] as int,
      content: json['content'] as String,
      createtime: json['createtime'] as int,
    );

Map<String, dynamic> _$ForwardToJson(Forward instance) => <String, dynamic>{
      'zfid': instance.zfid,
      'fromuid': instance.fromuid,
      'fromuname': instance.fromuname,
      'fromhead': instance.fromhead,
      'fromuserismember': instance.fromuserismember,
      'fromuserisvertify': instance.fromuserisvertify,
      'content': instance.content,
      'createtime': instance.createtime,
    };
