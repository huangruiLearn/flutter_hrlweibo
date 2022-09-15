// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FindHomeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FindHomeModel _$FindHomeModelFromJson(Map<String, dynamic> json) =>
    FindHomeModel(
      findkind: (json['findkind'] as List<dynamic>)
          .map((e) => Findkind.fromJson(e as Map<String, dynamic>))
          .toList(),
      findhottop: (json['findhottop'] as List<dynamic>)
          .map((e) => Findhottop.fromJson(e as Map<String, dynamic>))
          .toList(),
      findhotcenter:
          Findhotcenter.fromJson(json['findhotcenter'] as Map<String, dynamic>),
      findtopic: Findtopic.fromJson(json['findtopic'] as Map<String, dynamic>),
      findhot: (json['findhot'] as List<dynamic>)
          .map((e) => WeiBoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      findlocal: (json['findlocal'] as List<dynamic>)
          .map((e) => WeiBoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      findsupertopic: (json['findsupertopic'] as List<dynamic>)
          .map((e) => WeiBoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FindHomeModelToJson(FindHomeModel instance) =>
    <String, dynamic>{
      'findkind': instance.findkind,
      'findhottop': instance.findhottop,
      'findhotcenter': instance.findhotcenter,
      'findtopic': instance.findtopic,
      'findhot': instance.findhot,
      'findlocal': instance.findlocal,
      'findsupertopic': instance.findsupertopic,
    };

Findkind _$FindkindFromJson(Map<String, dynamic> json) => Findkind(
      id: json['id'] as int,
      name: json['name'] as String,
      img: json['img'] as String,
    );

Map<String, dynamic> _$FindkindToJson(Findkind instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'img': instance.img,
    };

Findhottop _$FindhottopFromJson(Map<String, dynamic> json) => Findhottop(
      hotid: json['hotid'] as String,
      hotdesc: json['hotdesc'] as String,
      hottype: json['hottype'] as String,
      hotread: json['hotread'] as String,
      hotattitude: json['hotattitude'] as int,
      hotdiscuss: json['hotdiscuss'] as String,
      hothost: json['hothost'] as String,
      recommendcoverimg: json['recommendcoverimg'] as String,
    );

Map<String, dynamic> _$FindhottopToJson(Findhottop instance) =>
    <String, dynamic>{
      'hotid': instance.hotid,
      'hotdesc': instance.hotdesc,
      'hottype': instance.hottype,
      'hotread': instance.hotread,
      'hotattitude': instance.hotattitude,
      'hotdiscuss': instance.hotdiscuss,
      'hothost': instance.hothost,
      'recommendcoverimg': instance.recommendcoverimg,
    };

Findhotcenter _$FindhotcenterFromJson(Map<String, dynamic> json) =>
    Findhotcenter(
      page1: (json['page1'] as List<dynamic>)
          .map((e) => Findhottop.fromJson(e as Map<String, dynamic>))
          .toList(),
      page2: (json['page2'] as List<dynamic>)
          .map((e) => Findhottop.fromJson(e as Map<String, dynamic>))
          .toList(),
      page3: (json['page3'] as List<dynamic>)
          .map((e) => Findhottop.fromJson(e as Map<String, dynamic>))
          .toList(),
      page4: (json['page4'] as List<dynamic>)
          .map((e) => Findhottop.fromJson(e as Map<String, dynamic>))
          .toList(),
      page5: (json['page5'] as List<dynamic>)
          .map((e) => Findhottop.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FindhotcenterToJson(Findhotcenter instance) =>
    <String, dynamic>{
      'page1': instance.page1,
      'page2': instance.page2,
      'page3': instance.page3,
      'page4': instance.page4,
      'page5': instance.page5,
    };

Findtopic _$FindtopicFromJson(Map<String, dynamic> json) => Findtopic(
      topic1: (json['topic1'] as List<dynamic>)
          .map((e) => Topic1.fromJson(e as Map<String, dynamic>))
          .toList(),
      topic2: (json['topic2'] as List<dynamic>)
          .map((e) => Topic1.fromJson(e as Map<String, dynamic>))
          .toList(),
      topic3: (json['topic3'] as List<dynamic>)
          .map((e) => Topic1.fromJson(e as Map<String, dynamic>))
          .toList(),
      topiclist: (json['topiclist'] as List<dynamic>)
          .map((e) => WeiBoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FindtopicToJson(Findtopic instance) => <String, dynamic>{
      'topic1': instance.topic1,
      'topic2': instance.topic2,
      'topic3': instance.topic3,
      'topiclist': instance.topiclist,
    };

Topic1 _$Topic1FromJson(Map<String, dynamic> json) => Topic1(
      topicid: json['topicid'] as String,
      topictype: json['topictype'] as String,
      topicdesc: json['topicdesc'] as String,
      topicread: json['topicread'] as String,
      topicdiscuss: json['topicdiscuss'] as String,
      topichost: json['topichost'] as String,
      topicattitude: json['topicattitude'] as String,
      topicimg: json['topicimg'] as String,
      topicintro: json['topicintro'] as String,
    );

Map<String, dynamic> _$Topic1ToJson(Topic1 instance) => <String, dynamic>{
      'topicid': instance.topicid,
      'topictype': instance.topictype,
      'topicdesc': instance.topicdesc,
      'topicread': instance.topicread,
      'topicdiscuss': instance.topicdiscuss,
      'topichost': instance.topichost,
      'topicattitude': instance.topicattitude,
      'topicimg': instance.topicimg,
      'topicintro': instance.topicintro,
    };
