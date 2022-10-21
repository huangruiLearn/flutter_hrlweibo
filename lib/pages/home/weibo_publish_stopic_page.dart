import 'dart:math';

import "package:dio/dio.dart";
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/model/topictype_response.dart';
import 'package:flutter_hrlweibo/public.dart';

class WeiBoPublishTopicPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WeiBoPublishTopicPageState();
  }
}

class WeiBoPublishTopicPageState extends State<WeiBoPublishTopicPage> {
  List<TopicTypeResponse> mLeftTopicTypeList = [];
  List<WeiBoTopic> mRightTopicList = [];
  int _selectCount = 0;
  void Function(int)? onMenuChecked;

  @override
  void initState() {
    super.initState();
    loadLeftTypeData();
    onMenuChecked = (int i) {
      if (_selectCount != i) {
        _selectCount = i;
      }
      setState(() {});

      loadRightTopicData(mLeftTopicTypeList[i].id.toString());
    };
  }

  void loadLeftTypeData() async {
    DioManager.instance.post(ServiceUrl.getWeiBoTopicTypeList, null,
        (data) {
      data.forEach((data) {
        mLeftTopicTypeList.add(TopicTypeResponse.fromJson(data));
      });
      loadRightTopicData(mLeftTopicTypeList[0].id.toString());
    }, (error) {});
  }

  void loadRightTopicData(String type) async {
    FormData params = FormData.fromMap({
      'topicType': type,
    });
    DioManager.instance.post(ServiceUrl.getWeiBoTopicList, params, (data) {
      // List<WeiboAtUser> listRecommend =[];
      //  List<WeiboAtUser> listNormal=[];
      mRightTopicList.clear();

      data.forEach((data) {
        mRightTopicList.add(WeiBoTopic.fromJson(data));
      });
      setState(() {});
    }, (error) {
      mRightTopicList.clear();
      setState(() {});
      print("error拉");
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Center(
                child: Container(
                  margin:
                      EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 10),
                  padding: EdgeInsets.only(top: 6, bottom: 6, left: 15),
                  decoration: BoxDecoration(
                    color: Color(0xffE4E2E8),
                    borderRadius: BorderRadius.all(
                      //圆角
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        "# 话题 电影 书 地点 股票",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 14, color: Color(0xffee565656)),
                      ),
                    ],
                  ),
                ),
              )),
              Container(
                margin: EdgeInsets.only(right: 15),
                child: Text(
                  "取消",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ],
          ),
          Container(
            color: Color(0xffEFEFEF),
            height: 1,
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                leftListv(3, mLeftTopicTypeList, onMenuChecked),
                RightListView()
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget leftListv(int i, List<TopicTypeResponse> myContent, onMenuCheckListener) {
    return Expanded(
      child: Container(
        color: Color(0xffEEEDF1),
        child: ListView.builder(
            itemCount: mLeftTopicTypeList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  onMenuCheckListener(index);
                },
                child: Container(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  decoration: BoxDecoration(
                    color: _selectCount == index
                        ? Colors.white
                        : Color(0xffEEEDF1),
                    border: Border(
                      left: BorderSide(
                          width: 5,
                          color: _selectCount == index
                              ? Color(0xffF79A03)
                              : Color(0xffEEEDF1)),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    mLeftTopicTypeList[index].name,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              );
            }),
      ),
      flex: i,
    );
  }

  Widget RightListView() {
    return Expanded(
      child: ListView.builder(
          itemCount: mRightTopicList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                print("选择的描述是:" + mRightTopicList[index].topicdesc);
                //   Navigator.of(context).pop(mRightTopicList[index]);

                Navigator.of(context).pop(mRightTopicList[index]);
              },
              child: Container(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                              width: 45,
                              height: 45,
                              margin: EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          '${mRightTopicList[index].topicimg}'),
                                      fit: BoxFit.cover))),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "#" + mRightTopicList[index].topicdesc + "#",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              Text(
                                "讨论" +
                                    mRightTopicList[index].topicdiscuss +
                                    "万",
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff999999)),
                              )
                            ],
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                    ),
                    Container(
                      color: Color(0xffEFEFEF),
                      height: 1,
                    )
                  ],
                ),
              ),
            );
          }),
      flex: 7,
    );
  }
}

getRandomColor() {
  return Color.fromARGB(255, Random.secure().nextInt(255),
      Random.secure().nextInt(255), Random.secure().nextInt(255));
}
