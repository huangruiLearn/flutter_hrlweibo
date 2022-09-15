import 'WeiBoModel.dart';

import 'package:json_annotation/json_annotation.dart';


part 'FindHomeModel.g.dart';

@JsonSerializable()
class FindHomeModel {
  List<Findkind> findkind;
  List<Findhottop> findhottop;
  Findhotcenter findhotcenter;
  Findtopic findtopic;
  List<WeiBoModel> findhot;
  List<WeiBoModel> findlocal;
  List<WeiBoModel> findsupertopic;


  FindHomeModel({required this.findkind,required this.findhottop,required this.findhotcenter,required this.findtopic,
    required this.findhot,required this.findlocal,required this.findsupertopic});

  factory FindHomeModel.fromJson(Map<String, dynamic> json) => _$FindHomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$FindHomeModelToJson(this);


}

@JsonSerializable()
class Findkind {
  int id;
  String name;
  String img;

  Findkind({required this.id,required this.name,required this.img});

  factory Findkind.fromJson(Map<String, dynamic> json) => _$FindkindFromJson(json);

  Map<String, dynamic> toJson() => _$FindkindToJson(this);

}

@JsonSerializable()
class Findhottop {
  String hotid;
  String hotdesc;
  String hottype;
  String hotread;
  int hotattitude;
  String hotdiscuss;
  String hothost;
  String recommendcoverimg;

  Findhottop({required this.hotid,required this.hotdesc,required this.hottype,
    required this.hotread,required this.hotattitude, required this.hotdiscuss ,
    required this.hothost,required this.recommendcoverimg  });

  factory Findhottop.fromJson(Map<String, dynamic> json) => _$FindhottopFromJson(json);

  Map<String, dynamic> toJson() => _$FindhottopToJson(this);

}

@JsonSerializable()
class Findhotcenter {
  List<Findhottop>? page1;
  List<Findhottop>? page2;
  List<Findhottop>? page3;
  List<Findhottop>? page4;
  List<Findhottop>? page5;

  Findhotcenter({  this.page1,  this.page2,  this.page3,  this.page4,  this.page5});

  factory Findhotcenter.fromJson(Map<String, dynamic> json) => _$FindhotcenterFromJson(json);

  Map<String, dynamic> toJson() => _$FindhotcenterToJson(this);

}

@JsonSerializable()
class Findtopic {
  List<Topic1>? topic1;
  List<Topic1>? topic2;
  List<Topic1>? topic3;
  List<WeiBoModel>? topiclist;

  Findtopic({  this.topic1,  this.topic2,  this.topic3,  this.topiclist});

  factory Findtopic.fromJson(Map<String, dynamic> json) => _$FindtopicFromJson(json);

  Map<String, dynamic> toJson() => _$FindtopicToJson(this);


}


@JsonSerializable()
class Topic1 {
  String topicid;
  String topictype;
  String topicdesc;
  String topicread;
  String topicdiscuss;
  String topichost;
  String topicattitude;
  String topicimg;
  String topicintro;

  Topic1(
      {required this.topicid,
        required this.topictype,
        required  this.topicdesc,
        required  this.topicread,
        required this.topicdiscuss,
        required this.topichost,
        required this.topicattitude,
        required this.topicimg,
        required this.topicintro});

  factory Topic1.fromJson(Map<String, dynamic> json) => _$Topic1FromJson(json);

  Map<String, dynamic> toJson() => _$Topic1ToJson(this);


}
