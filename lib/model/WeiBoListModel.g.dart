// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeiBoListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeiBoListModel _$WeiBoListModelFromJson(Map<String, dynamic> json) =>
    WeiBoListModel(
      status: json['status'] as int,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeiBoListModelToJson(WeiBoListModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      pageNum: json['pageNum'] as int,
      pageSize: json['pageSize'] as int,
      size: json['size'] as int,
       startRow: json['startRow'] as int,
      endRow: json['endRow'] as int,
      total: json['total'] as int,
      pages: json['pages'] as int,
      list: (json['list'] as List<dynamic>)
          .map((e) => WeiBoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstPage: json['firstPage'] as int,
      prePage: json['prePage'] as int,
      nextPage: json['nextPage'] as int,
      lastPage: json['lastPage'] as int,
      isFirstPage: json['isFirstPage'] as bool,
      isLastPage: json['isLastPage'] as bool,
      hasPreviousPage: json['hasPreviousPage'] as bool,
      hasNextPage: json['hasNextPage'] as bool,
      navigatePages: json['navigatePages'] as int,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'pageNum': instance.pageNum,
      'pageSize': instance.pageSize,
      'size': instance.size,
       'startRow': instance.startRow,
      'endRow': instance.endRow,
      'total': instance.total,
      'pages': instance.pages,
      'list': instance.list,
      'firstPage': instance.firstPage,
      'prePage': instance.prePage,
      'nextPage': instance.nextPage,
      'lastPage': instance.lastPage,
      'isFirstPage': instance.isFirstPage,
      'isLastPage': instance.isLastPage,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
      'navigatePages': instance.navigatePages,
    };
