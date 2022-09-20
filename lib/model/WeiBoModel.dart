import 'package:json_annotation/json_annotation.dart';

part 'WeiBoModel.g.dart';

@JsonSerializable()
class WeiBoModel {
  String weiboId;
  String categoryId;
  String content;
  WeiBoUserInfo userInfo;
  List<String> picurl;
  dynamic zfContent;
  dynamic zfNick;
  dynamic zfUserId;
  List<String> zfPicurl;
  dynamic zfWeiBoId;

  dynamic zfVedioUrl;
  bool containZf;

  String vediourl;
  String tail;
  int createtime;
  int zanStatus;

  int zhuanfaNum;
  int likeNum;
  int commentNum;

  WeiBoModel(
      {required this.weiboId,
      required this.categoryId,
      required this.content,
      required this.userInfo,
      required this.picurl,
      required this.zfContent,
      required this.zfNick,
      required this.zfUserId,
      required this.zfPicurl,
      required this.zfWeiBoId,
      required this.containZf,
      required this.vediourl,
      required this.zfVedioUrl,
      required this.tail,
      required this.createtime,
      required this.zanStatus,
      required this.zhuanfaNum,
      required this.likeNum,
      required this.commentNum});

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory WeiBoModel.fromJson(Map<String, dynamic> json) => _$WeiBoModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$WeiBoModelToJson(this);
}


@JsonSerializable()
class WeiBoUserInfo {
  int id;
  String nick;
  String headurl;
  String decs;
  int ismember;

  int isvertify;

  WeiBoUserInfo(
      {required this.id,
      required this.nick,
      required this.headurl,
      required this.decs,
      required this.ismember,
      required this.isvertify});


  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory WeiBoUserInfo.fromJson(Map<String, dynamic> json) => _$WeiBoUserInfoFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$WeiBoUserInfoToJson(this);
}
