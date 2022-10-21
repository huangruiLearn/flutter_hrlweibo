import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/model/WeiBoCommentList.dart';
import 'package:flutter_hrlweibo/model/WeiBoDetail.dart';
import 'package:flutter_hrlweibo/pages/home/weibo_comment_page.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:flutter_hrlweibo/util/date_util.dart';

class VideoDetailCommentPage extends StatefulWidget {
  @override
  _VideoDetailCommentPageState createState() => _VideoDetailCommentPageState();
}

ScrollController mCommentScrollController = new ScrollController();
List<Comment> mCommentList = [];
bool isCommentloadingMore = false; //是否显示加载中
bool isCommenthasMore = true; //是否还有更多
int mCommentCurPage = 1;

class _VideoDetailCommentPageState extends State<VideoDetailCommentPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 50),
          child: new ListView.builder(
            controller: mCommentScrollController,
            padding: new EdgeInsets.all(0.0),
            itemBuilder: (BuildContext context, int index) {
              return mCommentItem(context, index);
            },
            itemCount: mCommentList.length == 0 ? 1 : mCommentList.length + 2,
            //controller: mCommentScrollController,
          ),
        ),
        Positioned(
          child: new Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                  color: Colors.white,
                  height: 50,
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return CommentDialogPage("1", true, () {
                                //评论成功从新获取数据
                                mCommentScrollController.animateTo(.0,
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.ease);
                                getCommentDataLoadMore(mCommentCurPage, "1");
                              });
                            }));
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 15, right: 15),
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          decoration: BoxDecoration(
                            color: Color(0xffE4E2E8),
                            borderRadius: BorderRadius.all(
                              //圆角
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "说点什么",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xffee565656)),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ))),
        )
      ],
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mCommentScrollController.addListener(() {
      if (mCommentScrollController.position.pixels ==
          mCommentScrollController.position.maxScrollExtent) {
        if (!isCommentloadingMore) {
          if (isCommenthasMore) {
            setState(() {
              isCommentloadingMore = true;
              mCommentCurPage += 1;
            });
            Future.delayed(Duration(seconds: 3), () {
              getCommentDataLoadMore(mCommentCurPage, "1");
            });
          } else {
            setState(() {
              isCommenthasMore = false;
            });
          }
        }
      }
    });
    getCommentDataLoadMore(mCommentCurPage, "1");
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
                      text: mCommentList[index - 1].commentreply[0].fromuname +
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
                      text: mCommentList[index - 1].commentreply[1].fromuname +
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
                                (mCommentList[index - 1].fromuserisvertify == 1)
                                    ? Constant.ASSETS_IMG + 'home_vertify.webp'
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
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                        child: Text(mCommentList[index - 1].fromuname,
                            style: TextStyle(
                                fontSize: 11.0,
                                color:
                                    mCommentList[index - 1].fromuserismember ==
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
                          style:
                              TextStyle(color: Color(0xff333333), fontSize: 13),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: new BoxDecoration(
                          //背景
                          color: Color(0xffF7F7F7),
                          //设置四周圆角 角度
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
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
