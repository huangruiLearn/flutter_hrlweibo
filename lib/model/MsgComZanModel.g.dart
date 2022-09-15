// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MsgComZanModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComZanListModel _$ComZanListModelFromJson(Map<String, dynamic> json) =>
    ComZanListModel(
      pageNum: json['pageNum'] as int,
      pageSize: json['pageSize'] as int,
      size: json['size'] as int,
      orderBy: json['orderBy'] as String,
      startRow: json['startRow'] as int,
      endRow: json['endRow'] as int,
      total: json['total'] as int,
      pages: json['pages'] as int,
      list: (json['list'] as List<dynamic>)
          .map((e) => ComZanModel.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$ComZanListModelToJson(ComZanListModel instance) =>
    <String, dynamic>{
      'pageNum': instance.pageNum,
      'pageSize': instance.pageSize,
      'size': instance.size,
      'orderBy': instance.orderBy,
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

ComZanModel _$ComZanModelFromJson(Map<String, dynamic> json) => ComZanModel(
      userid: json['userid'] as String,
      username: json['username'] as String,
      userheadurl: json['userheadurl'] as String,
      createtime: json['createtime'] as int,
      content: json['content'] as String,
      tail: json['tail'] as String,
      weiboid: json['weiboid'] as String,
      weibcontent: json['weibcontent'] as String,
      weibousername: json['weibousername'] as String,
      weibopicurl: json['weibopicurl'] as String,
      ismember: json['ismember'] as int,
      isvertify: json['isvertify'] as int,
    );

Map<String, dynamic> _$ComZanModelToJson(ComZanModel instance) =>
    <String, dynamic>{
      'userid': instance.userid,
      'username': instance.username,
      'userheadurl': instance.userheadurl,
      'createtime': instance.createtime,
      'content': instance.content,
      'tail': instance.tail,
      'weiboid': instance.weiboid,
      'weibcontent': instance.weibcontent,
      'weibousername': instance.weibousername,
      'weibopicurl': instance.weibopicurl,
      'ismember': instance.ismember,
      'isvertify': instance.isvertify,
    };
