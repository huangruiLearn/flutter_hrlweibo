import "package:dio/dio.dart";
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/model/WeiBoCommentList.dart';
import 'package:flutter_hrlweibo/model/WeiBoDetail.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:flutter_hrlweibo/util/date_util.dart';

import 'wd_head.dart';
import 'weibo_comment_page.dart';

//评论详情界面
class WeiBoCommentDetailPage extends StatefulWidget {
  Comment mCommentTop;

  WeiBoCommentDetailPage(this.mCommentTop);

  @override
  _WeiBoCommentDetailPageState createState() => _WeiBoCommentDetailPageState();
}

class _WeiBoCommentDetailPageState extends State<WeiBoCommentDetailPage> {
  List<Comment> mCommentList = [];
  bool isloadingMore = false; //是否显示加载中
  bool ishasMore = true; //是否还有更多
  int mCurPage = 1;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    getCommentDataRefresh();
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

  Future getCommentDataRefresh() async {
    isloadingMore = false;
    ishasMore = true;
    mCurPage = 1;

    FormData formData = FormData.fromMap({
      'commentid': widget.mCommentTop.commentid,
      "pageNum": "1",
      "pageSize": Constant.PAGE_SIZE,
    });

    DioManager.instance.post(ServiceUrl.getWeiBoCommentReplyList, formData,
        (data) {
      mCommentList.clear();
      mCommentList.addAll(CommentList.fromJson(data).list);
      setState(() {});
    }, (error) {});
  }

  Future getSubDataLoadMore(int page) async {
    FormData formData = FormData.fromMap({
      'commentid': widget.mCommentTop.commentid,
      "pageNum": page,
      "pageSize": Constant.PAGE_SIZE,
    });
    await DioManager.instance
        .post(ServiceUrl.getWeiBoCommentReplyList, formData, (data) {
      DioManager.instance
          .post(ServiceUrl.getWeiBoCommentReplyList, formData, (data) {
        mCommentList.addAll(CommentList.fromJson(data).list);
        isloadingMore = false;
        ishasMore = CommentList.fromJson(data).list.length >=
            Constant.PAGE_SIZE;

        setState(() {});
      }, (error) {});
    }, (error) {
      setState(() {
        isloadingMore = false;
        ishasMore = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(child: WdHeadWidget("评论详情"), color: Colors.white),
          Expanded(
            child: RefreshIndicator(
              onRefresh: getCommentDataRefresh,
              child: CustomScrollView(
                controller: _scrollController,
                shrinkWrap: true,
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.only(top: 15, bottom: 20),
                      color: Colors.white,
                      child: mCommentWidget(widget.mCommentTop, true),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new Container(
                          margin:
                              EdgeInsets.only(right: 15, top: 10, bottom: 5),
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                Constant.ASSETS_IMG +
                                    'weibo_comment_shaixuan.png',
                                width: 15.0,
                                height: 17.0,
                              ),
                              Container(
                                child: Text('按时间',
                                    style: TextStyle(
                                        color: Color(0xff596D86),
                                        fontSize: 12)),
                                margin: EdgeInsets.only(left: 5.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(left: 40),
                      color: Color(0xffE6E4E3),
                      height: 0.5,
                    ),
                  ),
                  SliverPadding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          if (index == mCommentList.length) {
                            return _buildLoadMore();
                          } else {
                            return mCommentWidget(mCommentList[index], false);
                          }
                        },
                        childCount: mCommentList.length + 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              child: Container(
                child: InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    padding: EdgeInsets.only(top: 8, bottom: 8, left: 10),
                    decoration: BoxDecoration(
                      color: Color(0xffF4F4F4),
                      borderRadius: BorderRadius.all(
                        //圆角
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Text('回复评论',
                        style:
                            TextStyle(color: Color(0xff6E6E6E), fontSize: 13)),
                  ),
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return CommentDialogPage(
                              widget.mCommentTop.commentid, false, () {
                            _scrollController.animateTo(.0,
                                duration: Duration(milliseconds: 100),
                                curve: Curves.ease);
                            getCommentDataRefresh();
                          });
                        }));
                  },
                ),
                color: Colors.white,
              ),
            ),
            color: Color(0xffF9F9F9),
          )
        ],
      ),
    ));
  }

  Widget mCommentWidget(Comment mComment, bool isTop) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: mComment.fromuserisvertify == 0
                      ? Container(
                          width: 35.0,
                          height: 35.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            image: DecorationImage(
                                image: NetworkImage(mComment.fromhead),
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
                                      image: NetworkImage(mComment.fromhead),
                                      fit: BoxFit.cover),
                                )),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                child: Image.asset(
                                  (mComment.fromuserisvertify == 1)
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
                          child: Text(mComment.fromuname,
                              style: TextStyle(
                                  fontSize: 11.0,
                                  color: mComment.fromuserismember == 0
                                      ? Color(0xff636363)
                                      : Color(0xffF86119)))),
                    ),
                    Center(
                      child: mComment.fromuserismember == 0
                          ? new Container()
                          : Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Image.asset(
                                Constant.ASSETS_IMG + 'home_memeber.webp',
                                width: 15.0,
                                height: 13.0,
                              ),
                            ),
                    ),
                    Spacer(),
                    Row(
                      children: <Widget>[
                        Container(
                          child: Image.asset(
                            Constant.ASSETS_IMG + 'icon_like.png',
                            width: 15.0,
                            height: 15.0,
                          ),
                        ),
                        Visibility(
                          visible: isTop,
                          child: Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            child: Image.asset(
                              Constant.ASSETS_IMG + 'icon_comment.png',
                              width: 15.0,
                              height: 15.0,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 3),
                  child: Text(
                    DateUtil.getFormatTime2(DateTime.fromMillisecondsSinceEpoch(
                            mComment.createtime))
                        .toString(),
                    style: TextStyle(color: Color(0xff909090), fontSize: 11),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 3),
                  child: Text(
                    mComment.content,
                    style: TextStyle(color: Color(0xff333333), fontSize: 13),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /* Container(
                            child: Text(
                                "点赞转发布局"
                            ),
                          ),*/
                    ],
                  ),
                ),
                Visibility(
                  visible: !isTop,
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    height: 0.5,
                    color: Color(0xffE6E4E3),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
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
}
