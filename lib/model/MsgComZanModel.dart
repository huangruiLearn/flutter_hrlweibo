import 'package:json_annotation/json_annotation.dart';


part 'MsgComZanModel.g.dart';

@JsonSerializable()
class ComZanListModel {
  int pageNum;
  int pageSize;
  int size;
  String orderBy;
  int startRow;
  int endRow;
  int total;
  int pages;
  List<ComZanModel> list;
  int firstPage;
  int prePage;
  int nextPage;
  int lastPage;
  bool isFirstPage;
  bool isLastPage;
  bool hasPreviousPage;
  bool hasNextPage;
  int navigatePages;

  ComZanListModel(
      {required this.pageNum,
        required this.pageSize,
        required this.size,
        required this.orderBy,
        required this.startRow,
        required this.endRow,
        required this.total,
        required this.pages,
        required this.list,
        required this.firstPage,
        required this.prePage,
        required this.nextPage,
        required this.lastPage,
        required this.isFirstPage,
        required this.isLastPage,
        required  this.hasPreviousPage,
        required  this.hasNextPage,
        required  this.navigatePages,
      });

  factory ComZanListModel.fromJson(Map<String, dynamic> json) => _$ComZanListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ComZanListModelToJson(this);

}


@JsonSerializable()
class ComZanModel {
  String userid;
  String username;
  String userheadurl;
  int createtime;
  String content;
  String tail;
  String weiboid;
  String weibcontent;
  String weibousername;
  String weibopicurl;
  int ismember;
  int isvertify;

  ComZanModel(
      {required this.userid,
        required this.username,
        required this.userheadurl,
        required  this.createtime,
        required   this.content,
        required  this.tail,
        required  this.weiboid,
        required  this.weibcontent,
        required  this.weibousername,
        required  this.weibopicurl,
        required  this.ismember,
        required  this.isvertify});

  factory ComZanModel.fromJson(Map<String, dynamic> json) => _$ComZanModelFromJson(json);

  Map<String, dynamic> toJson() => _$ComZanModelToJson(this);
}