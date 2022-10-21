import 'package:json_annotation/json_annotation.dart';


part 'VideoModel.g.dart';

@JsonSerializable()
 class VideoModel {
  int id;
  String coverimg;
  int videotime;
  dynamic playnum;
  int userid;
  dynamic tag;
  String recommengstr;
  int type;
  String introduce;
  int createtime;
  String username;
  String userheadurl;
  int userisvertify;
  int zannum;
  String videourl;
  dynamic userfancount;
  String userdesc;

  VideoModel(
      {required this.id,
        required this.coverimg,
        required  this.videotime,
        required  this.playnum,
        required  this.userid,
        required  this.tag,
        required  this.recommengstr,
        required  this.type,
        required  this.introduce,
        required this.createtime,
        required  this.username,
        required  this.userheadurl,
        required  this.userisvertify,
        required  this.zannum,
        required  this.videourl,
        required this.userfancount,
        required this.userdesc});


  factory VideoModel.fromJson(Map<String, dynamic> json) => _$VideoModelFromJson(json);

  Map<String, dynamic> toJson() => _$VideoModelToJson(this);

}