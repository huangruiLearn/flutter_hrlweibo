class FanFollowResponse {
  String id;
  String nick;
  String decs;
  String headurl;
  int relation;

  FanFollowResponse(
      {required this.id,
      required this.nick,
      required this.headurl,
      required this.decs,
      required this.relation});

  FanFollowResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'] == null? "" :json['id'],
        nick = json['nick'],
        headurl = json['headurl'],
        decs = json['decs'],
        relation = json['relation'];

  Map<String, dynamic> toJson() => {
        'name': id,
        'email': nick,
      };
}
