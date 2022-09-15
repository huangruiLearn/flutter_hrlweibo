
import 'package:json_annotation/json_annotation.dart';


part 'OtherUserModel.g.dart';

@JsonSerializable()
class OtherUser {
  String id;
  String username;
  String nick;
  String headurl;
  String decs;
  String gender;
  String followCount;
  String fanCount;
  int ismember ;//是否是会员 0不是 1是
  int isvertify ;//是否认证 0没认证 1已认证
  int relation;//0已关注,1未关注,2相互关注
  int createtime;

  OtherUser(
      {required this.id,
        required  this.username,
        required this.nick,
        required this.headurl,
        required  this.decs,
        required this.gender,
        required this.followCount,
        required  this.fanCount,
        required  this.ismember,
        required this.isvertify,
        required this.relation,
        required this.createtime});


  factory OtherUser.fromJson(Map<String, dynamic> json) => _$OtherUserFromJson(json);

  Map<String, dynamic> toJson() => _$OtherUserToJson(this);

}