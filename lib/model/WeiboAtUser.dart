import 'package:azlistview/azlistview.dart';

class WeiboAtUsers {
  List<WeiboAtUser> hotusers;
  List<WeiboAtUser> normalusers;

  WeiboAtUsers({this.hotusers, this.normalusers});

  WeiboAtUsers.fromJson(Map<String, dynamic> json) {
    if (json['hotusers'] != null) {
      hotusers = new List<WeiboAtUser>();
      json['hotusers'].forEach((v) {
        hotusers.add(new WeiboAtUser.fromJson(v));
      });
    }
    if (json['normalusers'] != null) {
      normalusers = new List<WeiboAtUser>();
      json['normalusers'].forEach((v) {
        normalusers.add(new WeiboAtUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hotusers != null) {
      data['hotusers'] = this.hotusers.map((v) => v.toJson()).toList();
    }
    if (this.normalusers != null) {
      data['normalusers'] = this.normalusers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WeiboAtUser extends ISuspensionBean{
  String id;
  String nick;
  String headurl;
  String decs;
  Null gender;
  Null followCount;
  Null fanCount;

  String tagIndex;
  String namePinyin;

  WeiboAtUser(
      {this.id,
        this.nick,
        this.headurl,
        this.decs,
        this.gender,
        this.followCount,
        this.fanCount});

  WeiboAtUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nick = json['nick'];
    headurl = json['headurl'];
    decs = json['decs'];
    gender = json['gender'];
    followCount = json['followCount'];
    fanCount = json['fanCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nick'] = this.nick;
    data['headurl'] = this.headurl;
    data['decs'] = this.decs;
    data['gender'] = this.gender;
    data['followCount'] = this.followCount;
    data['fanCount'] = this.fanCount;
    return data;
  }


  @override
  String getSuspensionTag() => tagIndex;



}