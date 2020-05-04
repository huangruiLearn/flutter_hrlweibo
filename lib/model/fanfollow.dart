


class FanFollowModel {
    String id;
    String nick;
    String decs;
    String headurl;
    int relation;

    FanFollowModel({this.id, this.nick, this.headurl, this.decs, this.relation});

    FanFollowModel.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      nick = json['nick'];
      headurl = json['headurl'];
      decs = json['decs'];
      relation = json['relation'];
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['id'] = this.id;
      data['nick'] = this.nick;
      data['headurl'] = this.headurl;
      data['decs'] = this.decs;
      data['relation'] = this.relation;
      return data;
    }
}




