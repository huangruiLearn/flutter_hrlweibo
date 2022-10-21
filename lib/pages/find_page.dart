import 'dart:math' as math;

import "package:dio/dio.dart";
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    hide NestedScrollView;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';
import 'package:flutter_hrlweibo/http/service_url.dart';
import 'package:flutter_hrlweibo/model/FindHomeModel.dart';
import 'package:flutter_hrlweibo/model/WeiBoModel.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:flutter_hrlweibo/widget/MyNoticeVecAnimation.dart';
import 'package:card_swiper/card_swiper.dart';

import '../widget/weiboitem/WeiBoItem.dart';
import 'find/find_topic.dart';
import 'home/weibo_detail_page.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> with TickerProviderStateMixin{
  //活动导航
  bool isFindKindVisible = false;
  final List<String> _tabValues = [
    '热点',
    '本地',
    '话题',
    '超话',
  ];
  final List<String> _HomeSearchValues = [
    '大家正在搜:  hrl本地微博上线啦!',
    '大家正在搜:  hrl话题微博上线啦!',
    '大家正在搜:  hrl超话微博上线啦!',
    '大家正在搜:  hrl热点微博上线啦!',
  ];
    TabController?   _controller;
  List<Findhottop> mTopHotSearchList = []; //顶部热搜列表
  List<Findkind> mFindKindList = []; //发现类型列表
  Findhotcenter mFindCenter=Findhotcenter();
  List<WeiBoModel> mFindHotList = []; //热点列表
  List<WeiBoModel> mFindLocalList = []; //本地列表
  Findtopic mFindTopic=Findtopic(); //话题模块
  List<WeiBoModel> mSuperTopicList = []; //超话列表

  bool _loading = true; //页面加载状态

  @override
  void initState() {
    // TODO: implement initState


    super.initState();
    _controller = TabController(
      length: _tabValues.length, //Tab页数量
      vsync: this,
    );
    getFindInfoDate();
  }

  //获取发现页信息
  Future<Null> getFindInfoDate() async {
    FormData formData = FormData.fromMap({"userId": UserUtil.getUserInfo().id});
    DioManager.instance.post(ServiceUrl.getFindHomeInfo, formData, (data) {
      print("返回的正确数据:${data}");
      FindHomeModel mModel = FindHomeModel.fromJson(data);
      setState(() {
        mTopHotSearchList = mModel.findhottop;
        mFindKindList = mModel.findkind;
        mFindCenter = mModel.findhotcenter;
        mFindTopic = mModel.findtopic;
        mFindHotList = mModel.findhot;
        mFindLocalList = mModel.findlocal;
        mSuperTopicList = mModel.findsupertopic;
        _loading = false;
      });
    }, (error) {
      _loading = false;
    });

    return null;
  }

  Widget firstWidget() {
    return Container(
        height: 800.0,
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              childAspectRatio: 6.0,
              crossAxisCount: 2,
            ),
            itemCount: 3 + 1,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return new Container();
            }));
  }

  Widget mCenterBannerItemWidegt(int i) {
    List<Findhottop> mCneterItem = [];
    if (i == 0) {
      mCneterItem = mFindCenter.page1!;
    } else if (i == 1) {
      mCneterItem = mFindCenter.page2!;
    } else if (i == 2) {
      mCneterItem = mFindCenter.page3!;
    } else if (i == 3) {
      mCneterItem = mFindCenter.page4!;
    } else if (i == 4) {
      mCneterItem = mFindCenter.page5!;
    }

    return new Row(
      children: <Widget>[
        new Expanded(
          flex: 3,
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 2.5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(mCneterItem[0].recommendcoverimg))),
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 8),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Color(0xffFB304E)),
                          padding:
                              EdgeInsets.only(left: 4, right: 5, bottom: 2),
                          child: Center(
                            child: Text("热搜",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white)),
                          ),
                        ),
                        Text(
                          "#" + mCneterItem[0].hotdesc + "#",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3),
                      child: Text(
                          mCneterItem[0].hotdiscuss +
                              "讨论  " +
                              mCneterItem[0].hotread +
                              "阅读",
                          style: TextStyle(fontSize: 10, color: Colors.white)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        new Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                new Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 2.5, bottom: 2.5, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                mCneterItem[1].recommendcoverimg))),
                    child: Container(
                        padding: EdgeInsets.only(left: 3, right: 3, bottom: 3),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "#" + mCneterItem[1].hotdesc + "#",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        )),
                  ),
                ),
                new Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 2.5, top: 2.5, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                mCneterItem[2].recommendcoverimg))),
                    child: Container(
                        padding: EdgeInsets.only(left: 3, right: 3, bottom: 3),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "#" + mCneterItem[2].hotdesc + "#",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        )),
                  ),
                ),
              ],
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double mHotSerachTopGridItemHeight = 30;
    final double mHotSerachTopGridItemWidth = size.width / 2;
    final double mFindKindGridItemHeight = 80;
    final double mFindKindGridItemWidth = size.width / 6;

    return Material(
        color: Colors.white,
        //使用NestedScrollViewRefreshIndicator代替RefreshIndicator,解决RefreshIndicatorNestedScrollView与冲突的问题
        //https://juejin.im/post/5beb91275188251d9e0c1d73
        child: RefreshIndicator(
            onRefresh: getFindInfoDate,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                // These are the slivers that show up in the "outer" scroll view.
                return <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                        child: Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 10, top: 15, right: 10),
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          decoration: BoxDecoration(
                            color: Color(0xffE4E2E8),
                            borderRadius: BorderRadius.all(
                              //圆角
                              Radius.circular(5.0),
                            ),
                          ),
                          child: Center(
                              child: Container(
                            child: MyNoticeVecAnimation(
                                messages: _HomeSearchValues),
                          ))),
                    )),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset(
                                Constant.ASSETS_IMG + 'find_search.png',
                                width: 22.0,
                                height: 25.0,
                              ),
                              Text(
                                '微博热搜',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                  height: 120.0,
                                  child: GridView.builder(
                                      primary: false,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 0.0,
                                        crossAxisSpacing: 0.0,
                                        childAspectRatio:
                                            (mHotSerachTopGridItemWidth /
                                                mHotSerachTopGridItemHeight),
                                        crossAxisCount: 2,
                                      ),
                                      itemCount: mTopHotSearchList.length + 1,
                                      itemBuilder: (
                                        BuildContext context,
                                        int index,
                                      ) {
                                        return mHotSearchTopItem(
                                          context,
                                          index,
                                          mTopHotSearchList,
                                        );
                                      })),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 15),
                                  width: 1,
                                  color: Color(0xffE4E4E4),
                                  height: 90,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 10,
                            color: Color(0xffEEEEEE),
                          ),
                        ],
                      )
                    ]),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: isFindKindVisible
                          ? mFindKindGridItemHeight * 3
                          : mFindKindGridItemHeight,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: GridView.builder(
                          primary: false,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 0.0,
                            crossAxisSpacing: 0.0,
                            childAspectRatio: (mFindKindGridItemWidth /
                                mFindKindGridItemHeight),
                            crossAxisCount: 6,
                          ),
                          itemCount: isFindKindVisible ? 15 : 6,
                          itemBuilder: (
                            BuildContext context,
                            int index,
                          ) {
                            return mFindKindItem(context, index, mFindKindList);
                          }),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 190,
                      child: new ConstrainedBox(
                          child: new Swiper(
                            outer: true,
                            pagination: new SwiperPagination(
                                builder: DotSwiperPaginationBuilder(
                                  size: 7,
                                  space: 5,
                                  activeSize: 7,
                                  color: Color(0xffF0F0F0),
                                  activeColor: Color(0xffD8D8D8),
                                ),
                                margin: EdgeInsets.all(0)),
                            itemBuilder: (c, i) {
                              return mCenterBannerItemWidegt(i);
                            },
                            itemCount: mFindCenter == null ? 0 : 5,
                          ),
                          constraints:
                              new BoxConstraints.loose(new Size(300, 100.0))),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 10,
                      color: Color(0xffEEEEEE),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: _SliverAppBarDelegate(
                        minHeight: 50.0,
                        maxHeight: 50.0,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Center(
                                child: TabBar(
                                    isScrollable: true,
                                    indicatorColor: Color(0xffFF3700),
                                    indicator: UnderlineTabIndicator(
                                        borderSide: BorderSide(
                                            color: Color(0xffFF3700), width: 2),
                                        insets: EdgeInsets.only(bottom: 7)),
                                    labelColor: Color(0xff333333),
                                    unselectedLabelColor: Color(0xff666666),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700),
                                    unselectedLabelStyle:
                                        TextStyle(fontSize: 16.0),
                                    indicatorSize: TabBarIndicatorSize.label,
                                    controller: _controller,
                                    tabs: [
                                      new Tab(
                                        text: _tabValues[0],
                                      ),
                                      new Tab(
                                        text: _tabValues[1],
                                      ),
                                      new Tab(
                                        text: _tabValues[2],
                                      ),
                                      new Tab(
                                        text: _tabValues[3],
                                      ),
                                    ]),
                              ),
                            ),
                            Container(
                              height: 0.5,
                              color: Color(0xffE5E5E5),
                            ),
                          ],
                        )),
                  ),
                ];
              },
              body: RefreshIndicator(
                onRefresh: getFindInfoDate,
                child: TabBarView(controller: _controller,
                    // These are the contents of the tab views, below the tabs.
                    children: <Widget>[
                      new ListView.builder(
                        itemCount: mFindHotList.length,
                        itemBuilder: (context, index) {
                          return getContentItem(context, index, mFindHotList);
                        },
                      ),
                      new ListView.builder(
                        itemCount: mFindLocalList.length,
                        itemBuilder: (context, index) {
                          return getContentItem(context, index, mFindLocalList);
                        },
                      ),
                      (mFindTopic == null)
                          ? new Container()
                          : FindTopicPage(mModel: mFindTopic),
                      new ListView.builder(
                        itemCount: mSuperTopicList.length,
                        itemBuilder: (context, index) {
                          return getContentItem(
                              context, index, mSuperTopicList);
                        },
                      ),
                    ]),
              ),
            )));
  }

  getContentItem(BuildContext context, int index, List<WeiBoModel> mList) {
    WeiBoModel model = mList[index];
    // return model.momentType == 0 ? getItemTextContainer(model, index) : getItemImageContainer(model, index);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return WeiBoDetailPage(
            mModel: model,
          );
        }));
      },
      child: WeiBoItemWidget(model, false),
    );
  }

  Widget mHotSearchTopItem(
      BuildContext context, int index, List<Findhottop> mItemList) {
    // BorderSide borderSide = BorderSide(width: 1, color: Color(0xffE6E6E6));
    BorderSide borderSide = BorderSide(width: 2, color: Colors.green);
    Widget mChild;
    Widget? mHotSearchTypeWidget;

    if (index == mItemList.length) {
      mChild = GestureDetector(
        onTap: () {
          Routes.navigateTo(context, Routes.hotSearchPage);
        },
        child: Row(
          children: <Widget>[
            Text(
              "更多热搜",
              maxLines: 1,
              style: TextStyle(fontSize: 15, color: Color(0xffFB7A0E)),
            ),
            Image.asset(
              Constant.ASSETS_IMG + 'find_hs_more.png',
              width: 20.0,
              height: 20.0,
            ),
          ],
        ),
      );
    } else {
      if ("1" == mItemList[index].hottype) {
        mHotSearchTypeWidget = Image.asset(
          Constant.ASSETS_IMG + 'find_hs_hot.jpg',
          width: 17.0,
          height: 17.0,
        );
      } else if ("2" == mItemList[index].hottype) {
        mHotSearchTypeWidget = Image.asset(
          Constant.ASSETS_IMG + 'find_hs_new.jpg',
          width: 17.0,
          height: 17.0,
        );
      } else if ("3" == mItemList[index].hottype) {
        mHotSearchTypeWidget = Image.asset(
          Constant.ASSETS_IMG + 'find_hot_rec.jpg',
          width: 17.0,
          height: 17.0,
        );
      } else if ("null" == mItemList[index].hottype) {
        mHotSearchTypeWidget = Container();
      }
      var size = MediaQuery.of(context).size;

      mChild = Container(
        color: Colors.white,
        child: GestureDetector(
            onTap: () {
              Routes.navigateTo(
                context,
                Routes.topicDetailPage,
                params: {
                  'mTitle': mItemList[index].hotdesc,
                  'mImg': mItemList[index].recommendcoverimg,
                  'mReadCount': mItemList[index].hotread,
                  'mDiscussCount': mItemList[index].hotdiscuss,
                  'mHost': mItemList[index].hothost,
                },
              );
            },
            child: Row(
              children: <Widget>[
                Flexible(
                  //  width: "null"==mItemList[index].hottype?itemWidth:itemWidth2 ,
                  child: Text(
                    mItemList[index].hotdesc + "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 20),
                  child: mHotSearchTypeWidget,
                ),
              ],
            )),
      );
    }

    EdgeInsetsGeometry mMargin;
    if (index % 2 != 0) {
      mMargin = EdgeInsets.only(left: 0, right: 10);
    } else {
      mMargin = EdgeInsets.only(left: 10, right: 0);
    }

    return Container(
        margin: mMargin,
        padding: (index % 2 == 0)
            ? EdgeInsets.only(left: 0, right: 0)
            : EdgeInsets.only(left: 10, right: 0),
        child: mChild);
  }

  Widget mFindKindItem(
      BuildContext context, int index, List<Findkind> mItemList) {
    if (mItemList.length == 0) return new Container();
    Widget mKindChild;
    if (index == 5) {
      mKindChild = Container(
        height: 80,
        child: GestureDetector(
          onTap: () {
            isFindKindVisible = !isFindKindVisible;
            setState(() {});
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                isFindKindVisible
                    ? Image.asset(
                        Constant.ASSETS_IMG + 'find_more_top.png',
                        width: 38.0,
                        height: 38.0,
                      )
                    : Image.asset(
                        Constant.ASSETS_IMG + 'find_more_bottom.png',
                        width: 38.0,
                        height: 38.0,
                      ),
                Text(
                  mItemList[index].name + "",
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      mKindChild = Container(
          height: 80,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.network(mItemList[index].img,
                    fit: BoxFit.fill, width: 38, height: 38),
                Text(
                  mItemList[index].name + "",
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ));
    }

    return mKindChild;
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
