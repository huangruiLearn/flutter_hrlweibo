import 'dart:convert' as convert;
import 'dart:math' as math;

import "package:dio/dio.dart";
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';
import 'package:flutter_hrlweibo/model/WeiBoCommentList.dart';
import 'package:flutter_hrlweibo/model/WeiBoDetail.dart';
import 'package:flutter_hrlweibo/model/WeiBoForwardList.dart';
import 'package:flutter_hrlweibo/model/WeiBoModel.dart';
import 'package:flutter_hrlweibo/pages/home/weibo_retweet_page.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:flutter_hrlweibo/util/date_util.dart';
import 'package:flutter_hrlweibo/widget/likebutton/like_button.dart';
import 'package:flutter_hrlweibo/widget/likebutton/utils/like_button_model.dart';

import '../../widget/weiboitem/WeiBoDetailTop.dart';
import 'wd_head.dart';
import 'weibo_comment_page.dart';

class WeiBoDetailPage extends StatefulWidget {
  final WeiBoModel mModel;

  WeiBoDetailPage({   Key? key,required this.mModel}) : super(key: key);

  @override
  _WeiBoDetailState createState() => _WeiBoDetailState(mWeiboTopData: mModel);
}

class _WeiBoDetailState extends State<WeiBoDetailPage> with SingleTickerProviderStateMixin{
  final List<String> _tabValues = [
    '转发',
    '评论',
  ];
  TabController? _controller;
  WeiBoModel mWeiboTopData;
  ScrollController mCommentScrollController = new ScrollController();
  List<Comment> mCommentList = [];
  List<Forward> mForwardList = [];
  bool isCommentloadingMore = false; //是否显示加载中
  bool isCommenthasMore = true; //是否还有更多
  int mCommentCurPage = 1;
  bool isForwardloadingMore = false; //是否显示加载中
  bool isForwarhasMore = true; //是否还有更多
  int mForwardCurPage = 1;

  _WeiBoDetailState({required this.mWeiboTopData});

  @override
  void initState() {
    super.initState();
    getWeiBoDeatilData();
    _controller = TabController(
      length: _tabValues.length, //Tab页数量
      vsync: this,
    );
  }

  Future getWeiBoDeatilData() async {
    FormData params = FormData.fromMap({
      'weiboid': mWeiboTopData.weiboId,
    });
    DioManager.instance.post(ServiceUrl.getWeiBoDetail, params, (data) {
      mForwardList.clear();
      mForwardList.addAll(WeiBoDetail.fromJson(data).forward);
      mCommentList.clear();
      mCommentList.addAll(WeiBoDetail.fromJson(data).comment);
      isCommentloadingMore = false; //是否显示加载中
      isCommenthasMore = true; //是否还有更多
      mCommentCurPage = 1;
      isForwardloadingMore = false; //是否显示加载中
      isForwarhasMore = true; //是否还有更多
      mForwardCurPage = 1;
      setState(() {});
    }, (error) {});
  }

  Future getCommentDataLoadMore(int page, String weiboId) async {
    FormData formData = FormData.fromMap(
        {"pageNum": page, "pageSize": Constant.PAGE_SIZE, "weiboid": weiboId});
    DioManager.instance.post(ServiceUrl.getWeiBoDetailComment, formData,
        (data) {
      CommentList mComment = CommentList.fromJson(data);
      setState(() {
        mCommentList.addAll(mComment.list);
        isCommentloadingMore = false;
        isCommenthasMore = mComment.list.length >= Constant.PAGE_SIZE;
      });
    }, (error) {
      setState(() {
        isCommentloadingMore = false;
        isCommenthasMore = false;
      });
    });
  }

  Future getForwardDataLoadMore(int page, String weiboId) async {
    FormData formData = FormData.fromMap(
        {"pageNum": page, "pageSize": Constant.PAGE_SIZE, "weiboid": weiboId});
    DioManager.instance.post(ServiceUrl.getWeiBoDetailForward, formData,
        (data) {
      ForwardList mComment = ForwardList.fromJson(data);
      setState(() {
        mForwardList.addAll(mComment.list);
        isForwardloadingMore = false;
        isForwarhasMore = mComment.list.length >= Constant.PAGE_SIZE;
        print("是否还有更多赋值:" + isForwarhasMore.toString());
      });
    }, (error) {
      setState(() {
        isCommentloadingMore = false;
        isCommenthasMore = false;
      });
    });
  }

  Future<bool> onLikeButtonTapped(bool isLiked, WeiBoModel weiboItem) async {
    final Completer<bool> completer = new Completer<bool>();

    FormData formData = FormData.fromMap({
      "weiboId": weiboItem.weiboId,
      "userId": UserUtil.getUserInfo().id,
      "status": weiboItem.zanStatus == 0 ? 1 : 0, //1点赞,0取消点赞
    });
    DioManager.instance.post(ServiceUrl.zanWeiBo, formData, (data) {
      if (weiboItem.zanStatus == 0) {
        //点赞成功
        weiboItem.zanStatus = 1;
        weiboItem.likeNum++;
        completer.complete(true);
      } else {
        //取消点赞成功
        weiboItem.zanStatus = 0;
        weiboItem.likeNum--;
        completer.complete(false);
      }
    }, (error) {
      if (weiboItem.zanStatus == 0) {
        completer.complete(false);
      } else {
        completer.complete(true);
      }
    });

    return completer.future;
  }

  //当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // var commentListSize;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
                Container(child: WdHeadWidget("微博正文"), color: Colors.white),
                Expanded(
                  child: new NestedScrollView(
                    //controller: mCommentScrollController,
                    headerSliverBuilder: (context, bool) {
                      return [
                        SliverToBoxAdapter(
                          child: Container(height: 8, color: Color(0xffEFEFEF)),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            color: Colors.white,
                            child: WeiBoDetailTopWidget(mModel: mWeiboTopData),
                          ),
                        ),
                        SliverPersistentHeader(
                          pinned: true,
                          floating: true,
                          delegate: _SliverAppBarDelegate(
                              minHeight: 51.0,
                              maxHeight: 51.0,
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 50,
                                          color: Colors.white,
                                          child: TabBar(
                                              isScrollable: true,
                                              indicatorColor: Color(0xffFF3700),
                                              indicator: UnderlineTabIndicator(
                                                  borderSide: BorderSide(
                                                      color: Color(0xffFF3700),
                                                      width: 2),
                                                  insets: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      bottom: 7)),
                                              labelColor: Color(0xff333333),
                                              unselectedLabelColor:
                                                  Color(0xff666666),
                                              labelStyle: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w700),
                                              unselectedLabelStyle:
                                                  TextStyle(fontSize: 14.0),
                                              indicatorSize:
                                                  TabBarIndicatorSize.label,
                                              controller: _controller,
                                              tabs: [
                                                new Tab(
                                                  text: _tabValues[0] +
                                                      widget.mModel.zhuanfaNum
                                                          .toString(),
                                                ),
                                                new Tab(
                                                  text: _tabValues[1] +
                                                      widget.mModel.commentNum
                                                          .toString(),
                                                ),
                                              ]),
                                        ),
                                        Spacer(),
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Text("赞",
                                                  style: TextStyle(
                                                      color: Color(0xff949494),
                                                      fontSize: 14)),
                                              Text(
                                                  widget.mModel.likeNum
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Color(0xff949494),
                                                      fontSize: 14)),
                                            ],
                                          ),
                                          margin: EdgeInsets.only(right: 15),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 0.5,
                                      color: Color(0xffE6E4E3),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ];
                    },
                    body: TabBarView(
                      controller: _controller,
                      children: <Widget>[
                        /*      new ListView.builder(
                          padding: new EdgeInsets.all(5.0),
                          itemExtent: 50.0,
                          itemBuilder: (BuildContext context, int index) {
                            return new Text("text $index");
                          },
                          itemCount: 50,
                        ),*/
                        mForwardWidget(),
                        mCommentWidget(),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  child: _detailBottom(context, mWeiboTopData),
                  color: Color(0xffF9F9F9),
                )
              ],
            )));
  }

  Widget mForwardWidget() {
    return NotificationListener<ScrollNotification>(
      child: new ListView.builder(
        physics: ClampingScrollPhysics(),
        padding: new EdgeInsets.all(0.0),
        //   itemExtent: 50.0,
        itemBuilder: (BuildContext context, int index) {
          return mForwardItem(context, index);
        },
        itemCount: mForwardList.length + 1,
        //  controller: mCommentScrollController,
      ),
      onNotification: (ScrollNotification scrollInfo) =>
          _onScrollNotification(scrollInfo),
    );
  }

  _onScrollNotification(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      //滑到了底部
      print("滑动到了底部");

      if (!isForwardloadingMore) {
        if (isForwarhasMore) {
          setState(() {
            isForwardloadingMore = true;
            mForwardCurPage += 1;
          });
          Future.delayed(Duration(seconds: 3), () {
            getForwardDataLoadMore(mForwardCurPage, widget.mModel.weiboId);
          });
        } else {
          setState(() {
            isForwarhasMore = false;
          });
        }
      }
    }
  }

  Widget mCommentWidget() {
    return NotificationListener<ScrollNotification>(
      child: new ListView.builder(
        padding: new EdgeInsets.all(0.0),
        //   itemExtent: 50.0,
        itemBuilder: (BuildContext context, int index) {
          return mCommentItem(context, index);
        },
        itemCount: mCommentList.length == 0 ? 1 : mCommentList.length + 2,
        //controller: mCommentScrollController,
      ),
      onNotification: (ScrollNotification scrollInfo) =>
          _onScrollNotification2(scrollInfo),
    );
  }

  _onScrollNotification2(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      //滑到了底部
      print("滑动到了底部");
      if (!isCommentloadingMore) {
        if (isCommenthasMore) {
          setState(() {
            isCommentloadingMore = true;
            mCommentCurPage += 1;
          });
          Future.delayed(Duration(seconds: 3), () {
            getCommentDataLoadMore(mCommentCurPage, widget.mModel.weiboId);
          });
        } else {
          setState(() {
            isCommenthasMore = false;
          });
        }
      }
    }
  }

  Widget mForwardItem(BuildContext context, int index) {
    if (index == mForwardList.length) {
      return buildForwardLoadMore();
    }

    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: mForwardList[index].fromuserisvertify == 0
                      ? Container(
                          width: 35.0,
                          height: 35.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            image: DecorationImage(
                                image:
                                    NetworkImage(mForwardList[index].fromhead),
                                fit: BoxFit.cover),
                          ))
                      : Stack(
                          children: <Widget>[
                            Container(
                                width: 35.0,
                                height: 35.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          mForwardList[index].fromhead),
                                      fit: BoxFit.cover),
                                )),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                child: Image.asset(
                                  (mForwardList[index].fromuserisvertify == 1)
                                      ? Constant.ASSETS_IMG +
                                          'home_vertify.webp'
                                      : Constant.ASSETS_IMG +
                                          'home_vertify2.webp',
                                  width: 15.0,
                                  height: 15.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Center(
                      child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          child: Text(mForwardList[index].fromuname,
                              style: TextStyle(
                                  fontSize: 11.0,
                                  color:
                                      mForwardList[index].fromuserismember == 0
                                          ? Color(0xff636363)
                                          : Color(0xffF86119)))),
                    ),
                    Center(
                      child: mForwardList[index].fromuserismember == 0
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
                Container(
                  margin: EdgeInsets.only(top: 3),
                  child: Text(
                    mForwardList[index].content,
                    style: TextStyle(color: Color(0xff333333), fontSize: 13),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          DateUtil.getFormatTime2(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      mForwardList[index].createtime))
                              .toString(),
                          style:
                              TextStyle(color: Color(0xff909090), fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 0.5,
                  color: Color(0xffE6E4E3),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget mCommentItem(BuildContext context, int index) {
    if (index == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(right: 15, top: 10, bottom: 10),
            alignment: Alignment.centerRight,
            child: Row(
              children: <Widget>[
                Image.asset(
                  Constant.ASSETS_IMG + 'weibo_comment_shaixuan.png',
                  width: 15.0,
                  height: 17.0,
                ),
                Container(
                  child: Text('按热度',
                      style: TextStyle(color: Color(0xff596D86), fontSize: 12)),
                  margin: EdgeInsets.only(left: 5.0),
                ),
              ],
            ),
          )
        ],
      );
    }

    if (index == mCommentList.length + 1) {
      return buildCommentLoadMore();
    }

    Widget? mCommentReplyWidget;
    if (mCommentList[index - 1].commentreplynum == 0) {
    } else if (mCommentList[index - 1].commentreplynum == 1) {
      mCommentReplyWidget = new Container(
        padding: EdgeInsets.all(5),
        child: RichText(
            text: TextSpan(
                text: mCommentList[index - 1].commentreply[0].fromuname + ": ",
                style: TextStyle(fontSize: 12.0, color: Color(0xff45587E)),
                children: <TextSpan>[
              TextSpan(
                text: mCommentList[index - 1].commentreply[0].content,
                style: TextStyle(fontSize: 12.0, color: Color(0xff333333)),
              )
            ])),
      );
    } else if (mCommentList[index - 1].commentreplynum == 2) {
      mCommentReplyWidget = new Container(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  //margin: EdgeInsets.only(top: 2),
                  child: RichText(
                      text: TextSpan(
                          text: mCommentList[index - 1]
                                  .commentreply[0]
                                  .fromuname +
                              ": ",
                          style: TextStyle(
                              fontSize: 12.0, color: Color(0xff45587E)),
                          children: <TextSpan>[
                    TextSpan(
                      text: mCommentList[index - 1].commentreply[0].content,
                      style:
                          TextStyle(fontSize: 12.0, color: Color(0xff333333)),
                    )
                  ]))),
              Container(
                  margin: EdgeInsets.only(top: 3),
                  child: RichText(
                      text: TextSpan(
                          text: mCommentList[index - 1]
                                  .commentreply[1]
                                  .fromuname +
                              ": ",
                          style: TextStyle(
                              fontSize: 12.0, color: Color(0xff45587E)),
                          children: <TextSpan>[
                        TextSpan(
                          text: mCommentList[index - 1].commentreply[1].content,
                          style: TextStyle(
                              fontSize: 12.0, color: Color(0xff333333)),
                        )
                      ]))),
            ],
          ));
    } else {
      mCommentReplyWidget = new Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                //margin: EdgeInsets.only(top: 2),
                child: RichText(
                    text: TextSpan(
                        text:
                            mCommentList[index - 1].commentreply[0].fromuname +
                                ": ",
                        style:
                            TextStyle(fontSize: 12.0, color: Color(0xff45587E)),
                        children: <TextSpan>[
                  TextSpan(
                    text: mCommentList[index - 1].commentreply[0].content,
                    style: TextStyle(fontSize: 12.0, color: Color(0xff333333)),
                  )
                ]))),
            Container(
                margin: EdgeInsets.only(top: 3),
                child: RichText(
                    text: TextSpan(
                        text:
                            mCommentList[index - 1].commentreply[1].fromuname +
                                ": ",
                        style:
                            TextStyle(fontSize: 12.0, color: Color(0xff45587E)),
                        children: <TextSpan>[
                      TextSpan(
                        text: mCommentList[index - 1].commentreply[1].content,
                        style:
                            TextStyle(fontSize: 12.0, color: Color(0xff333333)),
                      )
                    ]))),
            Container(
              margin: EdgeInsets.only(top: 2),
              child: Row(
                children: <Widget>[
                  Text(
                    "共" +
                        mCommentList[index - 1].commentreplynum.toString() +
                        "条回复 >",
                    style: TextStyle(color: Color(0xff45587E), fontSize: 12),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: mCommentList[index - 1].fromuserisvertify == 0
                      ? Container(
                          width: 35.0,
                          height: 35.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            image: DecorationImage(
                                image: NetworkImage(
                                    mCommentList[index - 1].fromhead),
                                fit: BoxFit.cover),
                          ))
                      : Stack(
                          children: <Widget>[
                            Container(
                                width: 35.0,
                                height: 35.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          mCommentList[index - 1].fromhead),
                                      fit: BoxFit.cover),
                                )),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                child: Image.asset(
                                  (mCommentList[index - 1].fromuserisvertify ==
                                          1)
                                      ? Constant.ASSETS_IMG +
                                          'home_vertify.webp'
                                      : Constant.ASSETS_IMG +
                                          'home_vertify2.webp',
                                  width: 15.0,
                                  height: 15.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Center(
                      child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          child: Text(mCommentList[index - 1].fromuname,
                              style: TextStyle(
                                  fontSize: 11.0,
                                  color: mCommentList[index - 1]
                                              .fromuserismember ==
                                          0
                                      ? Color(0xff636363)
                                      : Color(0xffF86119)))),
                    ),
                    Center(
                      child: mCommentList[index - 1].fromuserismember == 0
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
                Container(
                  child: InkWell(
                    onTap: () {
                      Routes.navigateTo(context, Routes.weiboCommentDetailPage,
                          params: {
                            'comment':
                                convert.jsonEncode(mCommentList[index - 1]),
                          },
                          transition: TransitionType.fadeIn);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 3),
                          child: Text(
                            mCommentList[index - 1].content,
                            style: TextStyle(
                                color: Color(0xff333333), fontSize: 13),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: new BoxDecoration(
                            //背景
                            color: Color(0xffF7F7F7),
                            //设置四周圆角 角度
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                          margin: EdgeInsets.only(
                              top: mCommentList[index - 1].commentreplynum == 0
                                  ? 0
                                  : 5,
                              right: 15),
                          child: mCommentReplyWidget,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          DateUtil.getFormatTime2(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      mCommentList[index - 1].createtime))
                              .toString(),
                          style:
                              TextStyle(color: Color(0xff909090), fontSize: 11),
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Image.asset(
                              Constant.ASSETS_IMG + 'icon_retweet.png',
                              width: 15.0,
                              height: 15.0,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Image.asset(
                              Constant.ASSETS_IMG + 'icon_comment.png',
                              width: 15.0,
                              height: 15.0,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Image.asset(
                              Constant.ASSETS_IMG + 'icon_like.png',
                              width: 15.0,
                              height: 15.0,
                            ),
                          ),
                        ],
                      )

                      /* Container(
                            child: Text(
                                "点赞转发布局"
                            ),
                          ),*/
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  height: 0.5,
                  color: Color(0xffE6E4E3),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildForwardLoadMore() {
    return isForwardloadingMore
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
            child: isForwarhasMore
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

  Widget buildCommentLoadMore() {
    return isCommentloadingMore
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
            child: isCommenthasMore
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

  //转发收藏点赞布局
  Widget _detailBottom(BuildContext context, WeiBoModel weiboItem) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Flexible(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return RetWeetPage(
                  mModel: weiboItem,
                );
              }));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  Constant.ASSETS_IMG + 'icon_retweet.png',
                  width: 20.0,
                  height: 20.0,
                ),
                Container(
                  child: Text('转发',
                      style: TextStyle(color: Colors.black, fontSize: 13)),
                  margin: EdgeInsets.only(left: 5.0),
                ),
              ],
            ),
          ),
          flex: 1,
        ),
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          width: 1.0,
          color: Colors.black12,
        ),
        new Flexible(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return CommentDialogPage(weiboItem.weiboId, true, () {
                      //评论成功从新获取数据
                      mCommentScrollController.animateTo(.0,
                          duration: Duration(milliseconds: 100),
                          curve: Curves.ease);
                      getWeiBoDeatilData();
                    });
                  }));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  Constant.ASSETS_IMG + 'icon_comment.png',
                  width: 20.0,
                  height: 20.0,
                ),
                Container(
                  child: Text('评论',
                      style: TextStyle(color: Colors.black, fontSize: 13)),
                  margin: EdgeInsets.only(left: 5.0),
                ),
              ],
            ),
          ),
          flex: 1,
        ),
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          width: 1.0,
          color: Colors.black12,
        ),
        new Flexible(
          child: LikeButton(
            isLiked: weiboItem.zanStatus == 1,
            onTap: (bool isLiked) {
              return onLikeButtonTapped(isLiked, weiboItem);
            },
            size: 5,
            circleColor:
                CircleColor(start: Colors.orange, end: Colors.deepOrange),
            bubblesColor: BubblesColor(
              dotPrimaryColor: Colors.orange,
              dotSecondaryColor: Colors.deepOrange,
            ),
            likeBuilder: (bool isLiked) {
              return /*Icon(
                    Icons.home,
                    color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                    size: 20,
                  )*/
                  Image.asset(
                isLiked
                    ? Constant.ASSETS_IMG + 'ic_home_liked.webp'
                    : Constant.ASSETS_IMG + 'ic_home_like.webp',
                width: 21.0,
                height: 21.0,
              );
            },
            likeCount: weiboItem.likeNum,
            countBuilder: (int count, bool isLiked, String text) {
              var color = isLiked ? Colors.orange : Colors.black;
              Widget result;
              if (count == 0) {
                result = Text(
                  "",
                  style: TextStyle(color: color, fontSize: 13),
                );
              } else
                result = Text(
                  text,
                  style: TextStyle(color: color, fontSize: 13),
                );
              return result;
            },
          ),
          flex: 1,
        ),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
     required this.minHeight,
    required this.maxHeight,
     required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
