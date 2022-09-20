// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeiBoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeiBoModel _$WeiBoModelFromJson(Map<String, dynamic> json) => WeiBoModel(
      weiboId: json['weiboId']  ,
      categoryId: json['categoryId'] ,
      content: json['content']  ,
      userInfo:
          WeiBoUserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
      picurl:
          (json['picurl'] as List<dynamic>).map((e) => e as String).toList(),
      zfContent: json['zfContent']  ,
      zfNick: json['zfNick'] ,
      zfUserId: json['zfUserId']  ,
      zfPicurl:
          (json['zfPicurl'] as List<dynamic>).map((e) => e as String).toList(),
      zfWeiBoId: json['zfWeiBoId']  ,
      containZf: json['containZf']  ,
      vediourl: json['vediourl'] ,
      zfVedioUrl: json['zfVedioUrl']  ,
      tail: json['tail']  ,
      createtime: json['createtime']  ,
      zanStatus: json['zanStatus'] ,
      zhuanfaNum: json['zhuanfaNum']   ,
      likeNum: json['likeNum'] ,
      commentNum: json['commentNum'] ,
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
