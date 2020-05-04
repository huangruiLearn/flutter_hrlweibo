
 class VideoModel {
  int id;
  String coverimg;
  int videotime;
  int playnum;
  int userid;
  String tag;
  String recommengstr;
  int type;
  String introduce;
  int createtime;
  String username;
  String userheadurl;
  int userisvertify;
  int zannum;
  String videourl;
  int userfancount;
   String userdesc;

  VideoModel(
      {this.id,
        this.coverimg,
        this.videotime,
        this.playnum,
        this.userid,
        this.tag,
        this.recommengstr,
        this.type,
        this.introduce,
        this.createtime,
         this.username,
        this.userheadurl,
        this.userisvertify,
        this.zannum,
        this.videourl,
        this.userfancount,
        this.userdesc});

  VideoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    coverimg = json['coverimg'];
    videotime = json['videotime'];
    playnum = json['playnum'];
    userid = json['userid'];
    tag = json['tag'];
    recommengstr = json['recommengstr'];
    type = json['type'];
    introduce = json['introduce'];
    createtime = json['createtime'];
    username = json['username'];
    userheadurl = json['userheadurl'];
    userisvertify = json['userisvertify'];
    zannum = json['zannum'];
    videourl = json['videourl'];
    userfancount = json['userfancount'];
    userdesc = json['userdesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['coverimg'] = this.coverimg;
    data['videotime'] = this.videotime;
    data['playnum'] = this.playnum;
    data['userid'] = this.userid;
    data['tag'] = this.tag;
    data['recommengstr'] = this.recommengstr;
    data['type'] = this.type;
    data['introduce'] = this.introduce;
    data['createtime'] = this.createtime;
    data['username'] = this.username;
    data['userheadurl'] = this.userheadurl;
    data['userisvertify'] = this.userisvertify;
    data['zannum'] = this.zannum;
    data['videourl'] = this.videourl;
    data['userfancount'] = this.userfancount;
    data['userdesc'] = this.userdesc;
    return data;
  }
}