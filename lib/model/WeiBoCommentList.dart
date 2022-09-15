import 'WeiBoDetail.dart';
import 'package:json_annotation/json_annotation.dart';


part 'WeiBoCommentList.g.dart';

@JsonSerializable()
class CommentList {
  List<Comment> list;

  CommentList({required this.list});

   factory CommentList.fromJson(Map<String, dynamic> json) => _$CommentListFromJson(json);

   Map<String, dynamic> toJson() => _$CommentListToJson(this);


}
