import "package:dio/dio.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/public.dart';

import '../../widget/my_refresh_load_list.dart';

class FFRecommendPage extends StatefulWidget {
  @override
  _FFRecommendPageState createState() => _FFRecommendPageState();
}

class _FFRecommendPageState extends State<FFRecommendPage> {
  ScrollController mListController = new ScrollController();
  List<FanFollowResponse> mRecommendList=[];

  num curPage = 1;
  bool isloadingMore = false; //是否显示加载中
  bool ishasMore = true; //是否还有更多

  //下拉刷新
  Future _pullToRefresh() async {
    getRecommendList(true);
  }

  //加载更多
  _FFRecommendPageState() {
    mListController.addListener(() {
      var maxScroll = mListController.position.maxScrollExtent;
      var pixels = mListController.position.pixels;
      if (maxScroll == pixels) {
        if (!isloadingMore) {
          if (ishasMore) {
            setState(() {
              isloadingMore = true;
              curPage += 1;
            });
            getRecommendList(false);
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

  //获取数据
  getRecommendList(bool isRefresh) {
    if (isRefresh) {
      isloadingMore = false;
      ishasMore = true;
      curPage = 1;
      FormData params = FormData.fromMap({
        'userId': UserUtil.getUserInfo().id,
        'pageNum': "$curPage",
        "pageSize": Constant.PAGE_SIZE,
      });

      DioManager.instance.post(ServiceUrl.getFanFollowRecommend, params,
          (data) {
        List<FanFollowResponse> list = [];
        data['data']['list'].forEach((data) {
          list.add(FanFollowResponse.fromJson(data));
        });
        mRecommendList = [];
        mRecommendList = list;
        setState(() {});
      }, (error) {});
    } else {
      FormData params = FormData.fromMap({
        'userId': UserUtil.getUserInfo().id,
        'pageNum': "$curPage",
        "pageSize": Constant.PAGE_SIZE,
      });
      DioManager.instance.post(ServiceUrl.getFanFollowRecommend, params,
          (data) {
        List<FanFollowResponse> list = [];
        data['data']['list'].forEach((data) {
          list.add(FanFollowResponse.fromJson(data));
        });
        mRecommendList.addAll(list);
        isloadingMore = false;
        ishasMore = list.length >= Constant.PAGE_SIZE;
        setState(() {});
      }, (error) {
        setState(() {
          isloadingMore = false;
          ishasMore = false;
        });
      });
    }
  }

  Widget mRecommendPage() {
   /* if (mRecommendList == null) {
      getRecommendList(true);
      return Column(
        children: <Widget>[
          mRecommendTop(),
          Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      );
    } else {*/
      return /*RefreshIndicator(
          child: ListView.builder(
            itemCount: mRecommendList.length + 2,
            itemBuilder: (context, i) => mRecommendItem(i),
            physics: const AlwaysScrollableScrollPhysics(),
            controller: mListController,
          ),
          onRefresh: _pullToRefresh);*/
        /*HrlListView<FanFollowResponse>(
            pageSize: 10,
            itemBuilder:_itemBuilder,
            pageFuture: (pageIndex) => getPosts(pageIndex )
        );*/
        CustomScrollView(
          slivers: <Widget>[
            // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
            SliverToBoxAdapter(
              child: Container(
                height: 120,
                color: Colors.green,
                child: Text('HeaderView',style: TextStyle(color: Colors.red,fontSize: 20),),
              ),
            ),

            HrlListView<FanFollowResponse>(
                pageSize: 10,
                itemBuilder:_itemBuilder,
                pageFuture: (pageIndex) => getPosts(pageIndex )
            ),

          ],
        );



  //  }
  }

  static Future<List<FanFollowResponse>> getPosts(offset ) async {
     await Future.delayed(Duration(milliseconds: 1000));
   //  print("页码数是:"+offset );

    FormData params = FormData.fromMap({
      'userId': UserUtil.getUserInfo().id,
      'pageNum':offset.toString() ,
      "pageSize": Constant.PAGE_SIZE,
    });
    Map<String, dynamic> json = await DioManager.instance.postTongbu(ServiceUrl.getFanFollowRecommend, params);
    List<FanFollowResponse> list = [];
    json['data']['list'].forEach((data) {
      list.add(FanFollowResponse.fromJson(data));
    });
     return list;
  }


  Widget _itemBuilder(context, FanFollowResponse entry, _) {

        FanFollowResponse mModel =entry;
        return Column(
          children: <Widget>[
            Container(
             // height: 200,
              padding: EdgeInsets.only(top: 13, bottom: 13),
              color: Colors.white,
              //child:new Text(    '${mModel.nick }'  ),
              child: Row(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: CircleAvatar(
                        //头像半径
                        radius: 22,
                        //头像图片 -> NetworkImage网络图片，AssetImage项目资源包图片, FileImage本地存储图片
                        backgroundImage: NetworkImage('${mModel.headurl}'),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          '${mModel.nick}',
                          style: TextStyle(
                              letterSpacing: 0,
                              color: Colors.black,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(
                          '${mModel.decs}',
                          style: TextStyle(
                              letterSpacing: 0,
                              color: Color(0xff666666),
                              fontSize: 12),
                        ),
                      )
                    ],
                  ),
                  /* Expanded(
                    child: new Align(
                      alignment: FractionalOffset.centerRight,
                      child: mFollowBtnWidget(mModel, _ - 1),
                    ),*/

                ],
              ),
            ),
            Container(
              height: 0.5,
              color: Colors.black12,
              //  margin: EdgeInsets.only(left: 60),
            ),
          ],
        );

    }



  Widget mRecommendTop() {
    return new Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 12, bottom: 12),
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
      ),
      child: new IntrinsicHeight(
        child: new Row(
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.only(left: 15.0),
              child: Image.asset(
                Constant.ASSETS_IMG + "icon_find_friend.png",
                width: 27,
                height: 27,
              ),
            ),
            new Expanded(
              child: new Container(
                margin: const EdgeInsets.only(left: 15.0),
                child: Text("去找名人大V",
                    style: TextStyle(fontSize: 15, color: Colors.black)),
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(left: 5.0, right: 15),
              child: Image.asset(
                Constant.ASSETS_IMG + "icon_right_arrow.png",
                width: 15,
                height: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mRecommendItem(i) {
    if (i == 0) {
      return mRecommendTop();
    } else if (i == mRecommendList.length + 1) {
      return _buildLoadMore();
    } else {
      FanFollowResponse mModel = mRecommendList[i - 1];
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 13, bottom: 13),
            color: Colors.white,
            //child:new Text(    '${mModel.nick }'  ),
            child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: CircleAvatar(
                      //头像半径
                      radius: 22,
                      //头像图片 -> NetworkImage网络图片，AssetImage项目资源包图片, FileImage本地存储图片
                      backgroundImage: NetworkImage('${mModel.headurl}'),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        '${mModel.nick}',
                        style: TextStyle(
                            letterSpacing: 0,
                            color: Colors.black,
                            fontSize: 14),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Text(
                        '${mModel.decs}',
                        style: TextStyle(
                            letterSpacing: 0,
                            color: Color(0xff666666),
                            fontSize: 12),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: new Align(
                    alignment: FractionalOffset.centerRight,
                    child: mFollowBtnWidget(mModel, i - 1),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 0.5,
            color: Colors.black12,
            //  margin: EdgeInsets.only(left: 60),
          ),
        ],
      );
    }
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

  Widget? mFollowBtnWidget(FanFollowResponse mModel, int position) {
    if (mModel.relation == 0) {
      return Container(
        margin: EdgeInsets.only(right: 15),
        child: InkWell(
          child: Container(
              padding: new EdgeInsets.only(
                  top: 4.0, bottom: 4.0, left: 6.0, right: 6.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xff999999)),
                borderRadius: new BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    Constant.ASSETS_IMG + "ic_alfllow.png",
                    width: 10,
                    height: 10,
                  ),
                  Text("已关注",
                      style: TextStyle(color: Color(0xff333333), fontSize: 12)),
                ],
              )),
          onTap: () {
            showCancelFollowDialog(mModel, position);
          },
        ),
      );
    } else if (mModel.relation == 1) {
      return Container(
        margin: EdgeInsets.only(right: 15),
        child: InkWell(
          child: Container(
            padding: new EdgeInsets.only(
                top: 4.0, bottom: 4.0, left: 6.0, right: 6.0),
            decoration: new BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.orange),
              borderRadius: new BorderRadius.circular(5.0),
            ),
            child: Text("+关注",
                style: TextStyle(color: Colors.orange, fontSize: 12)),
          ),
          onTap: () {
            FormData params = FormData.fromMap({
              'userid': UserUtil.getUserInfo().id,
              'otheruserid': mModel.id,
            });
            DioManager.instance.post(ServiceUrl.followOther, params,
                (data) {
              int mRelation = data['data']['relation'];
              (mRecommendList[position]).relation = mRelation;
              setState(() {});
            }, (error) {
              ToastUtil.show(error);
            });
          },
        ),
      );
    } else if (mModel.relation == 2) {
      return Container(
        margin: EdgeInsets.only(right: 15),
        child: InkWell(
          child: Container(
              padding: new EdgeInsets.only(
                  top: 4.0, bottom: 4.0, left: 6.0, right: 6.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xff999999)),
                borderRadius: new BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    Constant.ASSETS_IMG + "ic_huxiangfollow.png",
                    width: 10,
                    height: 10,
                  ),
                  Text("互相关注",
                      style: TextStyle(color: Color(0xff333333), fontSize: 12)),
                ],
              )),
          onTap: () {
            showCancelFollowDialog(mModel, position);
          },
        ),
      );
    }
  }

  Widget? showCancelFollowDialog(FanFollowResponse mModel, int position) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            // title: Text('我是标题'),
            content: Container(
              margin: EdgeInsets.only(top: 10, bottom: 5),
              child: Text('确定不再关注?'),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  '取消',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  '确定',
                  style: TextStyle(fontSize: 12, color: Colors.deepOrange),
                ),
                onPressed: () {
                  FormData params = FormData.fromMap({
                    'userid': UserUtil.getUserInfo().id,
                    'otheruserid': mModel.id,
                  });
                  DioManager.instance
                      .post(ServiceUrl.followCancelOther, params, (data) {
                    Navigator.of(context).pop();
                    int mRelation = data['data']['relation'];
                    (mRecommendList[position]).relation = mRelation;
                    setState(() {});
                  }, (error) {
                    ToastUtil.show(error);
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return mRecommendPage();
  }
}
