import 'package:azlistview/azlistview.dart';
import 'package:json_annotation/json_annotation.dart';


part 'SelectUser.g.dart';

@JsonSerializable()
class SelectUser extends ISuspensionBean {
  String name;
  String tagIndex;
  String namePinyin;

  SelectUser({
    required this.name,
    required this.tagIndex,
    required  this.namePinyin,
  });

  factory SelectUser.fromJson(Map<String, dynamic> json) => _$SelectUserFromJson(json);

  Map<String, dynamic> toJson() => _$SelectUserToJson(this);


  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() => "CityBean {" + " \"name\":\"" + name + "\"" + '}';
}
