

class WeiBoTopic {
  String topicid;
  String topictype;
  String topicdesc;
  String topicread;
  String topicdiscuss;
  String topichost;
  String topicattitude;
  String topicimg;

  WeiBoTopic(
      {this.topicid,
        this.topictype,
        this.topicdesc,
        this.topicread,
        this.topicdiscuss,
        this.topichost,
        this.topicattitude,
        this.topicimg});

  WeiBoTopic.fromJson(Map<String, dynamic> json) {
    topicid = json['topicid'];
    topictype = json['topictype'];
    topicdesc = json['topicdesc'];
    topicread = json['topicread'];
    topicdiscuss = json['topicdiscuss'];
    topichost = json['topichost'];
    topicattitude = json['topicattitude'];
    topicimg = json['topicimg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topicid'] = this.topicid;
    data['topictype'] = this.topictype;
    data['topicdesc'] = this.topicdesc;
    data['topicread'] = this.topicread;
    data['topicdiscuss'] = this.topicdiscuss;
    data['topichost'] = this.topichost;
    data['topicattitude'] = this.topicattitude;
    data['topicimg'] = this.topicimg;
    return data;
  }
}