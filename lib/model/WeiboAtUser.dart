import 'package:azlistview/azlistview.dart';
import 'package:json_annotation/json_annotation.dart';


part 'WeiboAtUser.g.dart';

@JsonSerializable()
class WeiboAtUsers {
  List<WeiboAtUser> hotusers;
  List<WeiboAtUser> normalusers;

  WeiboAtUsers({required this.hotusers,required this.normalusers});

  factory WeiboAtUsers.fromJson(Map<String, dynamic> json) => _$WeiboAtUsersFromJson(json);

  Map<String, dynamic> toJson() => _$WeiboAtUsersToJson(this);


}

@JsonSerializable()
class WeiboAtUser extends ISuspensionBean{
  String id;
  String nick;
  String headurl;
  String decs;
  String gender;
  String followCount;
  String fanCount;

  String? tagIndex;
  String? namePinyin;

  WeiboAtUser(
      {required this.id,
        required this.nick,
        required this.headurl,
        required this.decs,
        required this.gender,
        required  this.followCount,
        required this.fanCount});

  factory WeiboAtUser.fromJson(Map<String, dynamic> json) => _$WeiboAtUserFromJson(json);

  Map<String, dynamic> toJson() => _$WeiboAtUserToJson(this);


  @override
  String getSuspensionTag() => tagIndex!;



}