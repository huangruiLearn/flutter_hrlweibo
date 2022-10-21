import "package:dio/dio.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/public.dart';

class FanListPage extends StatefulWidget {
  @override
  FanListPageState createState() => FanListPageState();
}

class FanListPageState extends State<FanListPage> {
  ScrollController mListController = new ScrollController();
  List<FanFollowResponse> mFanList=[];
  num curPage = 1;
  bool isloadingMore = false; //是否显示加载中
  bool ishasMore = true; //是否还有更多
  var mTextController = new TextEditingController();

  //下拉刷新
  Future _pullToRefresh() async {
    getFanList(true);
  }

  //加载更多
  FanListPageState() {
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
            getFanList(false);
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
  getFanList(bool isRefresh) {
    if (isRefresh) {
      isloadingMore = false;
      ishasMore = true;
      curPage = 1;
      FormData params = FormData.fromMap({
        'mcurrentuserId': UserUtil.getUserInfo().id,
        'mqueryuseid': UserUtil.getUserInfo().id,
        'pageNum': "$curPage",
        'pageSize': "10"
      });
      DioManager.instance.post(ServiceUrl.getFanList, params, (data) {
        List<FanFollowResponse> list =[];
        data['list'].forEach((data) {
          list.add(FanFollowResponse.fromJson(data));
        });
        mFanList = [];
        mFanList = list;
        setState(() {});
      }, (error) {});
    } else {
      FormData params = FormData.fromMap({
        'mcurrentuserId': UserUtil.getUserInfo().id,
        'mqueryuseid': UserUtil.getUserInfo().id,
        'pageNum': "$curPage",
        'pageSize': "10"
      });
      DioManager.instance.post(ServiceUrl.getFanList, params, (data) {
        List<FanFollowResponse> list =[];
        data['list'].forEach((data) {
          list.add(FanFollowResponse.fromJson(data));
        });
        mFanList.addAll(list);
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

  Widget mFanPage() {
    if (mFanList == null) {
      getFanList(true);
      return Column(
        children: <Widget>[
          mFanTop(),
          Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      );
    } else {
      return RefreshIndicator(
          child: ListView.builder(
            itemCount: mFanList.length + 2,
            itemBuilder: (context, i) => mFollowItem(i),
            physics: const AlwaysScrollableScrollPhysics(),
            controller: mListController,
          ),
          onRefresh: _pullToRefresh);
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

  Widget mFanTop() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
          child: InkWell(
            child: Container(
                padding: new EdgeInsets.only(
                    top: 7.0, bottom: 7.0, left: 5.0, right: 5.0),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Image.asset(
                        Constant.ASSETS_IMG + "ic_search.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Expanded(
                        child: Text(
                      "搜索全部粉丝",
                      style: TextStyle(fontSize: 14, color: Color(0xff999999)),
                    ))
                  ],
                )),
            onTap: () {
              print("点击关注");
            },
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(
            left: 10,
            bottom: 5,
          ),
          child: Text(
            "全部粉丝",
            style: TextStyle(fontSize: 12, color: Color(0xff666666)),
          ),
        ),
      ],
    );
  }

  Widget mFollowItem(i) {
    if (i == 0) {
      return mFanTop();
    } else if (i == mFanList.length + 1) {
      return _buildLoadMore();
    } else {
      FanFollowResponse mModel = mFanList[i - 1];

      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 12, bottom: 12),
            color: Colors.white,
            //child:new Text(    '${mModel.nick }'  ),
            child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: CircleAvatar(
                      //头像半径
                      radius: 25,
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
                ))
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
              int mRelation = data['relation'];
              (mFanList[position]).relation = mRelation;
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
                    int mRelation = data['relation'];
                    (mFanList[position]).relation = mRelation;
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
    return mFanPage();
  }
}
