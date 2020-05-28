import "package:dio/dio.dart";
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';
import 'package:flutter_hrlweibo/http/service_url.dart';
import 'package:flutter_hrlweibo/model/MsgComZanModel.dart';
import 'package:flutter_hrlweibo/util/date_util.dart';
import 'package:flutter_hrlweibo/widget/weibo/match_text.dart';
import 'package:flutter_hrlweibo/widget/weibo/parsed_text.dart';

import '../../http/service_method.dart';

class MsgZanPage extends StatefulWidget {
  @override
  _MsgZanPageState createState() => _MsgZanPageState();
}

class _MsgZanPageState extends State<MsgZanPage> {
  bool isloadingMore = false; //是否显示加载中
  bool ishasMore = true; //是否还有更多
  num mCurPage = 1;
  ScrollController _scrollController = new ScrollController();
  List<ComZanModel> mZanList = [];

  Future getSubDataRefresh() async {
    isloadingMore = false;
    ishasMore = true;
    mCurPage = 1;
    FormData formData = FormData.fromMap({
      "pageNum": "1",
      "pageSize": Constant.PAGE_SIZE,
    });
    DioManager.getInstance().post(ServiceUrl.getMsgZanList, formData, (data) {
      ComZanListModel mList = ComZanListModel.fromJson(data['data']);
      mZanList.clear();
      mZanList = mList.list;
      setState(() {});
    }, (error) {
      setState(() {});
    });
  }

  Future getSubDataLoadMore(int page) async {
    FormData formData = FormData.fromMap({
      "pageNum": page,
      "pageSize": Constant.PAGE_SIZE,
    });
    await DioManager.getInstance().post(ServiceUrl.getMsgZanList, formData,
        (data) {
      ComZanListModel mList = ComZanListModel.fromJson(data['data']);
      mZanList.addAll(mList.list);
      setState(() {
        isloadingMore = false;
        ishasMore = mList.list.length >= Constant.PAGE_SIZE;
      });
    }, (error) {
      setState(() {
        isloadingMore = false;
        ishasMore = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSubDataRefresh();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("调用加载更多");
        if (!isloadingMore) {
          if (ishasMore) {
            setState(() {
              isloadingMore = true;
              mCurPage += 1;
            });
            Future.delayed(Duration(seconds: 3), () {
              getSubDataLoadMore(mCurPage);
            });
          } else {
            print('没有更多数据');
            setState(() {
              ishasMore = false;
            });
          }
        }
      }
    });
  }

  Widget _buildLoadMore() {
    return isloadingMore
        ? Container(
            child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Center(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: SizedBox(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                    height: 12.0,
                    width: 12.0,
                  ),
                ),
                Text("加载中..."),
              ],
            )),
          ))
        : new Container(
            child: ishasMore
                ? new Container()
                : Center(
                    child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          "没有更多数据",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ))),
          );
  }

  getContentItem(BuildContext context, int index, List<ComZanModel> mList) {
    return new Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _authorRow(context, mList[index]),
          Container(
            child: Row(
              children: <Widget>[
                Text(mList[index].content),
                Container(
                  padding: EdgeInsets.all(3),
                  margin: EdgeInsets.only(left: 10),
                  decoration: new BoxDecoration(
                    border:
                        new Border.all(color: Color(0xffFFC514), width: 0.5),
                    // 边色与边宽度
                    color: Color(0xffFFC514),
                    // 底色
                    //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
                    shape: BoxShape.circle, // 默认值也是矩形
                    //    borderRadius: new BorderRadius.circular((20.0)), // 圆角度
                  ),
                  child: Image.asset(
                    Constant.ASSETS_IMG + 'msg_zan.webp',
                    width: 10.0,
                    height: 10.0,
                  ),
                )
              ],
            ),
            margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 8),
          ),
          _retweetcontent(mList[index]),
          Container(
            margin: EdgeInsets.only(top: 13),
            height: 0.5,
            color: Colors.black12,
            //  margin: EdgeInsets.only(left: 60),
          ),
        ],
      ),
    );
  }

  Widget _retweetcontent(ComZanModel mModel) {
    print("图片地址是:" + mModel.weibopicurl);
    return InkWell(
      onTap: () {},
      child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          color: Color(0xFFF8F8F8),
          child: Row(
            children: <Widget>[
              new Container(
                child:
                    /*Image.network(
                    mModel.weibopicurl,
                    fit: BoxFit.fill,
                    width: 90,
                    height: 90),*/
                    FadeInImage.assetNetwork(
                        placeholder: Constant.ASSETS_IMG + 'img_default.png',
                        image: mModel.weibopicurl,
                        fit: BoxFit.fill,
                        width: 90,
                        height: 90),
              ),
              new Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '@' + mModel.weibousername,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    new Container(
                        margin: EdgeInsets.only(top: 5.0),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child:
                            /* Text('' + widget.mModel.content,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    )*/
                            ParsedText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: mModel.weibcontent,
                          style: TextStyle(
                              height: 1.5, fontSize: 13, color: Colors.grey),
                          parse: <MatchText>[
                            MatchText(
                                pattern: r"\[(@[^:]+):([^\]]+)\]",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                                renderText: ({String str, String pattern}) {
                                  Map<String, String> map =
                                      Map<String, String>();
                                  RegExp customRegExp = RegExp(pattern);
                                  Match match = customRegExp.firstMatch(str);
                                  map['display'] = match.group(1);
                                  map['value'] = match.group(2);
                                  print("正则:" +
                                      match.group(1) +
                                      "---" +
                                      match.group(2));
                                  return map;
                                },
                                onTap: (url) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return AlertDialog(
                                        title: new Text("Mentions clicked"),
                                        content: new Text("$url clicked."),
                                        actions: <Widget>[
                                          // usually buttons at the bottom of the dialog
                                          new FlatButton(
                                            child: new Text("Close"),
                                            onPressed: () {},
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }),
                            MatchText(
                                pattern: '#.*?#',
                                //       pattern: r"\B#+([\w]+)\B#",
                                //   pattern: r"\[(#[^:]+):([^#]+)\]",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                                renderText: ({String str, String pattern}) {
                                  Map<String, String> map =
                                      Map<String, String>();
                                  //  RegExp customRegExp = RegExp(pattern);
                                  //#fskljflsk:12#
                                  // Match match = customRegExp.firstMatch(str);

                                  /*  String idStr =str.substring(str.indexOf(";"),
                     (str.lastIndexOf("#")-1));*/

                                  String idStr = str.substring(
                                      str.indexOf(":") + 1,
                                      str.lastIndexOf("#"));
                                  String showStr = str
                                      .substring(str.indexOf("#"),
                                          str.lastIndexOf("#") + 1)
                                      .replaceAll(":" + idStr, "");
                                  map['display'] = showStr;
                                  map['value'] = idStr;
                                  //   print("正则:"+str+"---"+idStr+"--"+startIndex.toString()+"--"+str.lastIndexOf("#").toString());

                                  return map;
                                },
                                onTap: (url) async {
                                  print("点击的id:" + url);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return AlertDialog(
                                        title: new Text("Mentions clicked"),
                                        content: new Text("点击的id:" + url),
                                        actions: <Widget>[
                                          // usually buttons at the bottom of the dialog
                                          new FlatButton(
                                            child: new Text("Close"),
                                            onPressed: () {},
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }),
                            MatchText(
                              pattern: '(\\[/).*?(\\])',
                              //       pattern: r"\B#+([\w]+)\B#",
                              //   pattern: r"\[(#[^:]+):([^#]+)\]",
                              style: TextStyle(
                                fontSize: 13,
                              ),
                              renderText: ({String str, String pattern}) {
                                Map<String, String> map = Map<String, String>();
                                print("表情的正则:" + str);
                                String mEmoji2 = "";
                                try {
                                  String mEmoji = str.replaceAll(
                                      RegExp('(\\[/)|(\\])'), "");
                                  int mEmojiNew = int.parse(mEmoji);
                                  mEmoji2 = String.fromCharCode(mEmojiNew);
                                } on Exception catch (_) {
                                  mEmoji2 = str;
                                }
                                map['display'] = mEmoji2;

                                return map;
                              },
                            ),
                            MatchText(
                                pattern: '全文',
                                //       pattern: r"\B#+([\w]+)\B#",
                                //   pattern: r"\[(#[^:]+):([^#]+)\]",
                                style: TextStyle(
                                  color: Color(0xff5B778D),
                                  fontSize: 15,
                                ),
                                renderText: ({String str, String pattern}) {
                                  Map<String, String> map =
                                      Map<String, String>();
                                  map['display'] = '全文';
                                  map['value'] = '全文';
                                  return map;
                                },
                                onTap: (url) async {
                                  print("点击的id:" + url);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return AlertDialog(
                                        title: new Text("Mentions clicked"),
                                        content: new Text("点击的id:" + url),
                                        actions: <Widget>[
                                          // usually buttons at the bottom of the dialog
                                          new FlatButton(
                                            child: new Text("Close"),
                                            onPressed: () {},
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }),
                          ],
                        )),
                  ],
                ),
              )
            ],
          )),
    );
  }

  //发布者昵称头像布局
  Widget _authorRow(BuildContext context, ComZanModel mZanItem) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 2.0),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 5),
            child: mZanItem.isvertify == 0
                ? Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      image: DecorationImage(
                          image: NetworkImage(mZanItem.userheadurl),
                          fit: BoxFit.cover),
                    ))
                : Stack(
                    children: <Widget>[
                      Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            image: DecorationImage(
                                image: NetworkImage(mZanItem.userheadurl),
                                fit: BoxFit.cover),
                          )),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          child: Image.asset(
                            (mZanItem.isvertify == 1)
                                ? Constant.ASSETS_IMG + 'home_vertify.webp'
                                : Constant.ASSETS_IMG + 'home_vertify2.webp',
                            width: 15.0,
                            height: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                        child: Text(mZanItem.username,
                            style: TextStyle(
                                fontSize: 15.0,
                                color: mZanItem.ismember == 0
                                    ? Colors.black
                                    : Color(0xffF86119)))),
                  ),
                  Center(
                    child: mZanItem.ismember == 0
                        ? new Container()
                        : Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Image.asset(
                              Constant.ASSETS_IMG + 'home_memeber.webp',
                              width: 15.0,
                              height: 13.0,
                            ),
                          ),
                  )
                ],
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(6.0, 2.0, 0.0, 0.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                          DateUtil.getFormatTime2(
                              DateTime.fromMillisecondsSinceEpoch(
                                  mZanItem.createtime)),
                          style: TextStyle(
                              color: Color(0xff808080), fontSize: 11.0)),
                      Container(
                        margin: EdgeInsets.only(left: 7, right: 7),
                        child: Text("来自",
                            style: TextStyle(
                                color: Color(0xff808080), fontSize: 11.0)),
                      ),
                      Text(mZanItem.tail,
                          style: TextStyle(
                              color: Color(0xff5B778D), fontSize: 11.0))
                    ],
                  )),
            ],
          ),
          Expanded(
            child: new Align(
                alignment: FractionalOffset.centerRight,
                child: GestureDetector(
                  child: Container(
                    padding: new EdgeInsets.only(
                        top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: new BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      '回复',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: new AppBar(
          elevation: 0,
          title: new Text(
            '赞',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          leading: IconButton(
            icon: Image.asset(
              Constant.ASSETS_IMG + 'icon_back.png',
              width: 25.0,
              height: 25.0,
            ),
            onPressed: () {},
          ),
          backgroundColor: Color(0xffFAFAFA),
          centerTitle: true,
          actions: <Widget>[
            Container(
              child: Center(
                child: GestureDetector(
                    child: Text("设置",
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    onTap: () {}),
              ),
              margin: EdgeInsets.only(right: 15),
            )
          ],
        ),
        body: Container(
          child: RefreshIndicator(
            // key: _refreshIndicatorKey,

            onRefresh: getSubDataRefresh,
            child: new ListView.builder(
              itemCount: mZanList.length + 1,
              itemBuilder: (context, index) {
                if (index == mZanList.length) {
                  return _buildLoadMore();
                } else {
                  return getContentItem(context, index, mZanList);
                }
              },
              controller: _scrollController,
            ),
          ),
        ),
      ),
    );
  }
}
