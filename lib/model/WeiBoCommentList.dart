import 'WeiBoDetail.dart';

class CommentList {
  List<Comment> list;

  CommentList({
    this.list,
  });

  CommentList.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List<Comment>();
      json['list'].forEach((v) {
        list.add(new Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
