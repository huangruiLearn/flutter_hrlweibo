import 'WeiBoDetail.dart';
import 'package:json_annotation/json_annotation.dart';


part 'WeiBoForwardList.g.dart';


@JsonSerializable()
class ForwardList {
  List<Forward> list;

  ForwardList({required this.list});

  factory ForwardList.fromJson(Map<String, dynamic> json) => _$ForwardListFromJson(json);

  Map<String, dynamic> toJson() => _$ForwardListToJson(this);


}
