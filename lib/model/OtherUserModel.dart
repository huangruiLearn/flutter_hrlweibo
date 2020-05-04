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
      {this.id,
        this.username,
        this.nick,
        this.headurl,
        this.decs,
        this.gender,
        this.followCount,
        this.fanCount,
        this.ismember,
        this.isvertify,
        this.relation,
        this.createtime});

  OtherUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    nick = json['nick'];
    headurl = json['headurl'];
    decs = json['decs'];
    gender = json['gender'];
    followCount = json['followCount'];
    fanCount = json['fanCount'];
    ismember = json['ismember'];
     isvertify = json['isvertify'];
    relation = json['relation'];
    createtime = json['createtime'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['nick'] = this.nick;
    data['headurl'] = this.headurl;
    data['decs'] = this.decs;
    data['gender'] = this.gender;
    data['followCount'] = this.followCount;
    data['fanCount'] = this.fanCount;
    data['ismember'] = this.ismember;
    data['isvertify'] = this.isvertify;
    data['relation'] = this.relation;
    data['createtime'] = this.createtime;

    return data;
  }
}