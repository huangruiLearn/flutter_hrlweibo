import 'videocategory.dart';
import 'package:json_annotation/json_annotation.dart';


part 'VedioCategoryList.g.dart';

@JsonSerializable()
 class VedioCategoryList {
  int status;
  List<VedioCategory> data;
  VedioCategoryList({required this.status,required this.data});


  factory VedioCategoryList.fromJson(Map<String, dynamic> json) => _$VedioCategoryListFromJson(json);

  Map<String, dynamic> toJson() => _$VedioCategoryListToJson(this);

}
