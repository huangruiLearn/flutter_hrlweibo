import 'WeiBoModel.dart';
import 'package:json_annotation/json_annotation.dart';


part 'WeiBoListModel.g.dart';

@JsonSerializable()
class WeiBoListModel {
  int    status;
  Data    data;
  WeiBoListModel({required this.  status, required this. data });

  factory WeiBoListModel.fromJson(Map<String, dynamic> json) => _$WeiBoListModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeiBoListModelToJson(this);

}





@JsonSerializable()
class Data {
   int  pageNum;
   int  pageSize;
   int  size;
   String  orderBy;
  int  startRow;
  int  endRow;
  int  total;
  int  pages;
  List<WeiBoModel>  list;
  int  firstPage;
  int  prePage;
  int  nextPage;
  int  lastPage;
  bool  isFirstPage;
  bool  isLastPage;
  bool  hasPreviousPage;
  bool  hasNextPage;
  int  navigatePages;

  Data(
      {required this.pageNum,
        required this.pageSize,
        required this.size,
        required this.orderBy,
        required this.startRow,
        required this.endRow,
        required this.total,
        required  this.pages,
        required  this.list,
        required this.firstPage,
        required this.prePage,
        required this.nextPage,
        required this.lastPage,
        required this.isFirstPage,
        required this.isLastPage,
        required this.hasPreviousPage,
        required this.hasNextPage,
        required this.navigatePages,
        });

   factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

   Map<String, dynamic> toJson() => _$DataToJson(this);

}


