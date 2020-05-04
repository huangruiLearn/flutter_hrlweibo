import 'package:azlistview/azlistview.dart';

class SelectUser extends ISuspensionBean {
  String name;
  String tagIndex;
  String namePinyin;

  SelectUser({
    this.name,
    this.tagIndex,
    this.namePinyin,
  });

  SelectUser.fromJson(Map<String, dynamic> json)
      : name = json['name'] == null ? "" : json['name'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'tagIndex': tagIndex,
    'namePinyin': namePinyin,
    'isShowSuspension': isShowSuspension
  };

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() => "CityBean {" + " \"name\":\"" + name + "\"" + '}';
}
