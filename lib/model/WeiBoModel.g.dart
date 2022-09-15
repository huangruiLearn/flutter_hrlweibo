// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeiBoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeiBoModel _$WeiBoModelFromJson(Map<String, dynamic> json) => WeiBoModel(
      weiboId: json['weiboId'] as String,
      categoryId: json['categoryId'] as String,
      content: json['content'] as String,
      userInfo:
          WeiBoUserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
      picurl:
          (json['picurl'] as List<dynamic>).map((e) => e as String).toList(),
      zfContent: json['zfContent'] as String,
      zfNick: json['zfNick'] as String,
      zfUserId: json['zfUserId'] as String,
      zfPicurl:
          (json['zfPicurl'] as List<dynamic>).map((e) => e as String).toList(),
      zfWeiBoId: json['zfWeiBoId'] as String,
      containZf: json['containZf'] as bool,
      vediourl: json['vediourl'] as String,
      zfVedioUrl: json['zfVedioUrl'] as String,
      tail: json['tail'] as String,
      createtime: json['createtime'] as int,
      zanStatus: json['zanStatus'] as int,
      zhuanfaNum: json['zhuanfaNum'] as int,
      likeNum: json['likeNum'] as int,
      commentNum: json['commentNum'] as int,
    );

Map<String, dynamic> _$WeiBoModelToJson(WeiBoModel instance) =>
    <String, dynamic>{
      'weiboId': instance.weiboId,
      'categoryId': instance.categoryId,
      'content': instance.content,
      'userInfo': instance.userInfo,
      'picurl': instance.picurl,
      'zfContent': instance.zfContent,
      'zfNick': instance.zfNick,
      'zfUserId': instance.zfUserId,
      'zfPicurl': instance.zfPicurl,
      'zfWeiBoId': instance.zfWeiBoId,
      'zfVedioUrl': instance.zfVedioUrl,
      'containZf': instance.containZf,
      'vediourl': instance.vediourl,
      'tail': instance.tail,
      'createtime': instance.createtime,
      'zanStatus': instance.zanStatus,
      'zhuanfaNum': instance.zhuanfaNum,
      'likeNum': instance.likeNum,
      'commentNum': instance.commentNum,
    };

WeiBoUserInfo _$WeiBoUserInfoFromJson(Map<String, dynamic> json) =>
    WeiBoUserInfo(
      id: json['id'] as int,
      nick: json['nick'] as String,
      headurl: json['headurl'] as String,
      decs: json['decs'] as String,
      ismember: json['ismember'] as int,
      isvertify: json['isvertify'] as int,
    );

Map<String, dynamic> _$WeiBoUserInfoToJson(WeiBoUserInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nick': instance.nick,
      'headurl': instance.headurl,
      'decs': instance.decs,
      'ismember': instance.ismember,
      'isvertify': instance.isvertify,
    };
