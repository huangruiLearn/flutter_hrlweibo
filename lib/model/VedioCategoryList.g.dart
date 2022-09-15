// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VedioCategoryList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VedioCategoryList _$VedioCategoryListFromJson(Map<String, dynamic> json) =>
    VedioCategoryList(
      status: json['status'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => VedioCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VedioCategoryListToJson(VedioCategoryList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
