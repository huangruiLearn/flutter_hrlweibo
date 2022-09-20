class User {
  String? id;
  dynamic username;
  String? nick;
  String? headurl;
  String? decs;
  String? gender;
  String? followCount;
  String? fanCount;
  int? ismember;
  int  isvertify=0;

  User(
      {  this.id,
        this.username,
        this.nick,
        this.headurl,
        this.decs,
        this.gender,
        this.followCount,
        this.fanCount,
        this.ismember,
        this.isvertify=0});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        nick = json['nick'],
        headurl = json['headurl'],
        decs = json['decs'],
        gender = json['gender'],
        followCount = json['followCount'],
        fanCount = json['fanCount'],
        ismember = json['ismember'],
        isvertify = json['isvertify'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'nick': nick,
        'headurl': headurl,
        'decs': decs,
        'gender': gender,
        'followCount': followCount,
        'fanCount': fanCount,
        'ismember': ismember,
        'isvertify': isvertify,
      };
}
