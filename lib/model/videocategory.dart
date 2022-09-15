
import 'package:json_annotation/json_annotation.dart';


part 'videocategory.g.dart';

@JsonSerializable()
class VedioCategory {
  int id;
  String cname;



  VedioCategory({required this.id,required this.cname});


  factory VedioCategory.fromJson(Map<String, dynamic> json) => _$VedioCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$VedioCategoryToJson(this);



  @override
  String toString() {
    return 'VedioCategory{id: $id, cname: $cname}';
  }


}