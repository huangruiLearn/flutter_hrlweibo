

class WeiBoDetail {
  List<Comment> comment;
  List<Forward> forward;

  WeiBoDetail({this.comment, this.forward});

  WeiBoDetail.fromJson(Map<String, dynamic> json) {
    if (json['comment'] != null) {
      comment = new List<Comment>();
      json['comment'].forEach((v) {
        comment.add(new Comment.fromJson(v));
      });
    }
    if (json['forward'] != null) {
      forward = new List<Forward>();
      json['forward'].forEach((v) {
        forward.add(new Forward.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comment != null) {
      data['comment'] = this.comment.map((v) => v.toJson()).toList();
    }
    if (this.forward != null) {
      data['forward'] = this.forward.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comment {
  String commentid;
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
      {this.commentid,
        this.weiboid,
        this.fromuid,
        this.fromuname,
        this.fromhead,
        this.fromuserismember,
        this.fromuserisvertify,
        this.content,
        this.createtime,
        this.commentreply,
        this.commentreplynum});

  Comment.fromJson(Map<String, dynamic> json) {
    commentid = json['commentid'];
    weiboid = json['weiboid'];
    fromuid = json['fromuid'];
    fromuname = json['fromuname'];
    fromhead = json['fromhead'];
    fromuserismember = json['fromuserismember'];
    fromuserisvertify = json['fromuserisvertify'];
    content = json['content'];
    createtime = json['createtime'];
    if (json['commentreply'] != null) {
      commentreply = new List<Commentreply>();
      json['commentreply'].forEach((v) {
        commentreply.add(new Commentreply.fromJson(v));
      });
    }
    commentreplynum = json['commentreplynum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentid'] = this.commentid;
    data['weiboid'] = this.weiboid;
    data['fromuid'] = this.fromuid;
    data['fromuname'] = this.fromuname;
    data['fromhead'] = this.fromhead;
    data['fromuserismember'] = this.fromuserismember;
    data['fromuserisvertify'] = this.fromuserisvertify;
    data['content'] = this.content;
    data['createtime'] = this.createtime;
    if (this.commentreply != null) {
      data['commentreply'] = this.commentreply.map((v) => v.toJson()).toList();
    }
    data['commentreplynum'] = this.commentreplynum;
    return data;
  }
}

class Commentreply {
  Null commentid;
  String crid;
  String fromuid;
  String fromuname;
  String fromhead;
  int fromuserismember;
  int fromuserisvertify;
  String content;
  int createtime;

  Commentreply(
      {this.commentid,
        this.crid,
        this.fromuid,
        this.fromuname,
        this.fromhead,
        this.fromuserismember,
        this.fromuserisvertify,
        this.content,
        this.createtime});

  Commentreply.fromJson(Map<String, dynamic> json) {
    commentid = json['commentid'];
    crid = json['crid'];
    fromuid = json['fromuid'];
    fromuname = json['fromuname'];
    fromhead = json['fromhead'];
    fromuserismember = json['fromuserismember'];
    fromuserisvertify = json['fromuserisvertify'];
    content = json['content'];
    createtime = json['createtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentid'] = this.commentid;
    data['crid'] = this.crid;
    data['fromuid'] = this.fromuid;
    data['fromuname'] = this.fromuname;
    data['fromhead'] = this.fromhead;
    data['fromuserismember'] = this.fromuserismember;
    data['fromuserisvertify'] = this.fromuserisvertify;
    data['content'] = this.content;
    data['createtime'] = this.createtime;
    return data;
  }
}

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
      {this.zfid,
        this.fromuid,
        this.fromuname,
        this.fromhead,
        this.fromuserismember,
        this.fromuserisvertify,
        this.content,
        this.createtime});

  Forward.fromJson(Map<String, dynamic> json) {
    zfid = json['zfid'];
    fromuid = json['fromuid'];
    fromuname = json['fromuname'];
    fromhead = json['fromhead'];
    fromuserismember = json['fromuserismember'];
    fromuserisvertify = json['fromuserisvertify'];
    content = json['content'];
    createtime = json['createtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zfid'] = this.zfid;
    data['fromuid'] = this.fromuid;
    data['fromuname'] = this.fromuname;
    data['fromhead'] = this.fromhead;
    data['fromuserismember'] = this.fromuserismember;
    data['fromuserisvertify'] = this.fromuserisvertify;
    data['content'] = this.content;
    data['createtime'] = this.createtime;
    return data;
  }
}