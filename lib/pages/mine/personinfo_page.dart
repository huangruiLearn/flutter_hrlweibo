import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/model/OtherUserModel.dart';
import 'package:flutter_hrlweibo/public.dart';

class PersonInfoPage extends StatefulWidget {
  String mOtherUserId;

  PersonInfoPage(this.mOtherUserId);

  @override
  _PersonInfoPageState createState() => _PersonInfoPageState();
}

class _PersonInfoPageState extends State<PersonInfoPage>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();

  bool isShowBlackTitle = false;

  TabController? _tabController;
  OtherUser mUser = new OtherUser(
      id: "0",
       nick: "",
      headurl: "",
      decs: "",
      gender: "0",
      followCount: "0",
      fanCount: "0",
      ismember: 0,
      isvertify: 0,
      relation: 0,
      createtime: 0);

  @override
  void initState() {
    super.initState();
    fetchData();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 3);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  //判断滚动改变透明度
  void _onScroll(offset) {
    if (offset > 100) {
      setState(() {
        isShowBlackTitle = true;
      });
    } else {
      setState(() {
        isShowBlackTitle = false;
      });
    }
  }

  Future<void> fetchData() async {
    FormData params = FormData.fromMap({
      'muserId': UserUtil.getUserInfo().id,
      'otheruserId': widget.mOtherUserId,
    });
    DioManager.instance.post(ServiceUrl.getUserInfo, params, (data) {
      mUser = OtherUser.fromJson(data);
      setState(() {});
    }, (error) {});
  }

  var mTabs = <String>[
    '主页'
        '微博'
        '相册'
  ];

  /**
   * 模拟下拉刷新
   */
  Future<void> _onRefresh() async {}

  Column _timeSelection() {
    return Column(
      children: <Widget>[
        Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            Container(
              height: 50,
              color: Colors.white,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 70),
              child: TabBar(
                tabs: [
                  Tab(text: '主页'),
                  Tab(text: '微博'),
                  Tab(text: '相册'),
                ],
                controller: _tabController,
                isScrollable: false,
                labelPadding: EdgeInsets.symmetric(horizontal: 10),
                indicatorColor: Colors.deepOrange,
                indicatorPadding: EdgeInsetsDirectional.only(bottom: 3),
                labelColor: Colors.black,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                unselectedLabelColor: Color(0xff999999),
                unselectedLabelStyle:
                    TextStyle(fontSize: 15, color: Colors.black),
              ),
            )
          ],
        ),
        Container(
          height: 0.5,
          color: Colors.black12,
          //  margin: EdgeInsets.only(left: 60),
        ),
      ],
    );
  }

  Widget _detailBottom() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Flexible(
          child: Center(
            child: mFollowBtnWidget(),
            // margin: EdgeInsets.only(left: 5.0),
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
              Routes.navigateTo(context, Routes.chatPage,
                  transition: TransitionType.fadeIn);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text('聊天',
                      style: TextStyle(color: Colors.black, fontSize: 14)),
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
          child: Center(
            child: Text(
              "热门",
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
          flex: 1,
        ),
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          width: 1.0,
        ),
      ],
    );
  }

  Widget? mFollowBtnWidget() {
    if (mUser.relation == 0) {
      return Container(
        margin: EdgeInsets.only(right: 15),
        child: InkWell(
          child: Container(
              padding: new EdgeInsets.only(
                  top: 4.0, bottom: 4.0, left: 6.0, right: 6.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("已关注",
                      style: TextStyle(color: Color(0xff333333), fontSize: 14)),
                ],
              )),
          onTap: () {
            showCancelFollowDialog();
          },
        ),
      );
    } else if (mUser.relation == 1) {
      return Container(
        margin: EdgeInsets.only(right: 15),
        child: InkWell(
          child: Container(
            padding: new EdgeInsets.only(
                top: 4.0, bottom: 4.0, left: 6.0, right: 6.0),
            child: Text("+ 关注",
                style: TextStyle(color: Colors.black, fontSize: 14)),
          ),
          onTap: () {
            FormData params = FormData.fromMap({
              'userid': UserUtil.getUserInfo().id,
              'otheruserid': mUser.id,
            });
            DioManager.instance.post(ServiceUrl.followOther, params,
                (data) {
              int mRelation = data['relation'];
              mUser.relation = mRelation;
              setState(() {});
            }, (error) {
              ToastUtil.show(error);
            });
          },
        ),
      );
    } else if (mUser.relation == 2) {
      return Container(
        margin: EdgeInsets.only(right: 15),
        child: InkWell(
          child: Container(
              padding: new EdgeInsets.only(
                  top: 4.0, bottom: 4.0, left: 6.0, right: 6.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    Constant.ASSETS_IMG + "ic_huxiangfollow.png",
                    width: 10,
                    height: 10,
                  ),
                  Text("互相关注",
                      style: TextStyle(color: Color(0xff333333), fontSize: 14)),
                ],
              )),
          onTap: () {
            showCancelFollowDialog();
          },
        ),
      );
    }
  }

  Widget? showCancelFollowDialog() {
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
                    'otheruserid': mUser.id,
                  });
                  DioManager.instance
                      .post(ServiceUrl.followCancelOther, params, (data) {
                    Navigator.of(context).pop();
                    int mRelation = data['relation'];
                    mUser.relation = mRelation;
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
    return SafeArea(
        //  color: Colors.white,
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        NotificationListener(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollUpdateNotification &&
                  scrollNotification.depth == 0) {
                //滚动并且是列表滚动的时候
                _onScroll(scrollNotification.metrics.pixels);
              }
              return true;
            },
            child: Stack(
              children: <Widget>[
                NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    // These are the slivers that show up in the "outer" scroll view.
                    return <Widget>[
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                        sliver: SliverAppBar(
                          leading: new Container(
                            margin: EdgeInsets.only(top: 20, bottom: 10),
                            child: isShowBlackTitle
                                ? Image.asset(
                                    Constant.ASSETS_IMG +
                                        'userinfo_icon_back_black.png',
                                    fit: BoxFit.fitHeight,
                                  )
                                : Image.asset(
                                    Constant.ASSETS_IMG +
                                        'userinfo_icon_back_white.png',
                                    fit: BoxFit.fitHeight,
                                  ),
                          ),
                          title: isShowBlackTitle ? Text(mUser.nick) : Text(''),
                          centerTitle: true,
                          pinned: true,
                          floating: false,
                          snap: false,
                          primary: true,
                          expandedHeight: 210.0,
                          backgroundColor: Color(0xffF8F8F8),
                          elevation: 0,
                          //是否显示阴影，直接取值innerBoxIsScrolled，展开不显示阴影，合并后会显示
                          forceElevated: innerBoxIsScrolled,
                          actions: <Widget>[
                            new Container(
                              margin: EdgeInsets.only(
                                  right: 10, top: 20, bottom: 10),
                              child: isShowBlackTitle
                                  ? Image.asset(
                                      Constant.ASSETS_IMG +
                                          'userinfo_search_black.png',
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      Constant.ASSETS_IMG +
                                          'userinfo_search_white.png',
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            new Container(
                              margin: EdgeInsets.only(
                                  right: 10, top: 20, bottom: 10),
                              child: isShowBlackTitle
                                  ? Image.asset(
                                      Constant.ASSETS_IMG +
                                          'userinfo_more_black.png',
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      Constant.ASSETS_IMG +
                                          'userinfo_more_white.png',
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ],

                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.pin,
                            background: new Column(
                              children: <Widget>[
                                new Container(
                                  height: 210,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        Constant.ASSETS_IMG +
                                            'ic_personinfo_bg4.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: new Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: 25),
                                        child: new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: new CircleAvatar(
                                                  backgroundImage:
                                                      new NetworkImage(
                                                          mUser.headurl == null
                                                              ? ""
                                                              : mUser.headurl),
                                                  radius: 33.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(top: 15),
                                            child: Text(
                                              mUser.nick,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 15, left: 5),
                                            child: mUser.gender == "1"
                                                ? new Container(
                                                    child: Image.asset(
                                                      Constant.ASSETS_IMG +
                                                          'mine_male.webp',
                                                      width: 15,
                                                      height: 15,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : new Container(
                                                    child: Image.asset(
                                                      Constant.ASSETS_IMG +
                                                          'mine_female.png',
                                                      width: 15,
                                                      height: 15,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 15),
                                            child: mUser.ismember == 0
                                                ? new Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5),
                                                    child: Image.asset(
                                                      Constant.ASSETS_IMG +
                                                          'mine_openmember.webp',
                                                      width: 40.0,
                                                      height: 25.0,
                                                    ),
                                                  )
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5),
                                                    child: Image.asset(
                                                      Constant.ASSETS_IMG +
                                                          'home_memeber.webp',
                                                      width: 15.0,
                                                      height: 13.0,
                                                    ),
                                                  ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                "关注  " + mUser.followCount,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Container(
                                              color: Colors.white,
                                              height: 10,
                                              width: 1,
                                              margin: EdgeInsets.only(
                                                  left: 15, right: 15),
                                            ),
                                            Container(
                                              child: Text(
                                                "粉丝 " + mUser.fanCount,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          "简介: " + mUser.decs,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /* bottom: TabBar(
                        tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                      ),*/
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: _SliverAppBarDelegate2(_timeSelection()),
                        pinned: true,
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    // These are the contents of the tab views, below the tabs.
                    children: [
                      PersonInfoHomeHome(mUser.nick, mUser.decs,
                          mUser.createtime, mUser.gender),
                      PageInfoWeiBo(),
                      PageInfoPic(),
                    ],
                  ),
                ),
                UserUtil.getUserInfo().id == widget.mOtherUserId
                    ? new Container()
                    : Align(
                        //对齐底部
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            child: Container(
                          color: Colors.white,
                          child: _detailBottom(),
                          height: 50,
                        ))),
              ],
            )),
      ]),
    ));
  }
}

class _SliverAppBarDelegate2 extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate2(this._tabBar);

  final Column _tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _tabBar;
  }

  @override
  double get maxExtent => 52;

  @override
  double get minExtent => 52;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
