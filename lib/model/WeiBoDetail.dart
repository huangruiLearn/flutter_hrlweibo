
import 'package:json_annotation/json_annotation.dart';


part 'WeiBoDetail.g.dart';

@JsonSerializable()
class WeiBoDetail {
  List<Comment> comment;
  List<Forward> forward;

  WeiBoDetail({required this.comment,required this.forward});
  factory WeiBoDetail.fromJson(Map<String, dynamic> json) => _$WeiBoDetailFromJson(json);

  Map<String, dynamic> toJson() => _$WeiBoDetailToJson(this);
}


@JsonSerializable()
class Comment {
  dynamic commentid;
  String weiboid;
  String fromuid;
  String fromuname;
  String fromhead;
  int fromuserismember;
  int fromuserisvertify;
  String content;
  int createtime;
  List<Commentreply> commentreply;
  int commentreplynum;

  Comment(
      {required this.commentid,
        required this.weiboid,
        required  this.fromuid,
        required  this.fromuname,
        required this.fromhead,
        required this.fromuserismember,
        required this.fromuserisvertify,
        required  this.content,
        required  this.createtime,
        required this.commentreply,
        required this.commentreplynum});
  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

}

@JsonSerializable()
class Commentreply {
  dynamic commentid;
  String crid;
  String fromuid;
  String fromuname;
  String fromhead;
  int fromuserismember;
  int fromuserisvertify;
  String content;
  int createtime;

  Commentreply(
      {required this.commentid,
        required this.crid,
        required  this.fromuid,
        required  this.fromuname,
        required this.fromhead,
        required this.fromuserismember,
        required  this.fromuserisvertify,
        required  this.content,
        required this.createtime});
  factory Commentreply.fromJson(Map<String, dynamic> json) => _$CommentreplyFromJson(json);

  Map<String, dynamic> toJson() => _$CommentreplyToJson(this);

}



@JsonSerializable()
class Forward {
  String zfid;
  String fromuid;
  String fromuname;
  String fromhead;
  int fromuserismember;
  int fromuserisvertify;
  String content;
  int createtime;

  Forward(
      {required this.zfid,
        required this.fromuid,
        required this.fromuname,
        required this.fromhead,
        required this.fromuserismember,
        required  this.fromuserisvertify,
        required  this.content,
        required this.createtime});


  factory Forward.fromJson(Map<String, dynamic> json) => _$ForwardFromJson(json);

   Map<String, dynamic> toJson() => _$ForwardToJson(this);
}