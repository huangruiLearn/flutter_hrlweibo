
import 'package:json_annotation/json_annotation.dart';



class TopicTypeResponse {
  int id;
  String name;

  TopicTypeResponse({required this.id, required this.name});

  TopicTypeResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}
