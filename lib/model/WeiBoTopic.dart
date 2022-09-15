




import 'package:json_annotation/json_annotation.dart';


part 'WeiBoTopic.g.dart';

@JsonSerializable()

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
      {required this.topicid,
        required this.topictype,
        required this.topicdesc,
        required this.topicread,
        required this.topicdiscuss,
        required  this.topichost,
        required this.topicattitude,
        required  this.topicimg});


  factory WeiBoTopic.fromJson(Map<String, dynamic> json) => _$WeiBoTopicFromJson(json);

  Map<String, dynamic> toJson() => _$WeiBoTopicToJson(this);


}