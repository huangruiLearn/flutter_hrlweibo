import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/model/FindHomeModel.dart';
import 'package:flutter_hrlweibo/public.dart';

import '../../http/dio_manager.dart';

class HotSearchPage extends StatefulWidget {
  @override
  _HotSearchPageState createState() => _HotSearchPageState();
}

class _HotSearchPageState extends State<HotSearchPage> {
  bool isShowBlackTitle = false;
  List<Findhottop> mHotSearchList = [];

  //判断滚动改变透明度
  void listenScrollChangeTitle(offset) {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DioManager.instance.post(ServiceUrl.getHotSearchList, null, (data) {
      mHotSearchList.clear();
      data.forEach((data) {
        mHotSearchList.add(Findhottop.fromJson(data));
      });
      setState(() {});
    }, (error) {});
  }

  Widget? mHotSearchItem(int index) {
    Widget? mHotSearchTypeWidget;

    if ("1" == mHotSearchList[index].hottype) {
      mHotSearchTypeWidget = Image.asset(
        Constant.ASSETS_IMG + 'find_hs_hot.jpg',
        width: 17.0,
        height: 17.0,
      );
    } else if ("2" == mHotSearchList[index].hottype) {
      mHotSearchTypeWidget = Image.asset(
        Constant.ASSETS_IMG + 'find_hs_new.jpg',
        width: 17.0,
        height: 17.0,
      );
    } else if ("3" == mHotSearchList[index].hottype) {
      mHotSearchTypeWidget = Image.asset(
        Constant.ASSETS_IMG + 'find_hot_rec.jpg',
        width: 17.0,
        height: 17.0,
      );
    } else if ("null" == mHotSearchList[index].hottype) {
      mHotSearchTypeWidget = Container(
        height: 17.0,
      );
    }

    return Column(
      children: <Widget>[
        Container(
          height: 40,
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Text((index + 1).toString() + "",
                      style: TextStyle(
                        fontFamily: "HotSearch", // 指定该Text的字体。
                        fontSize: 14,
                        color: Colors.red,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Text(mHotSearchList[index].hotdesc + "",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      )),
                ),
                Container(
                  child: Text(mHotSearchList[index].hotread + "",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      )),
                ),
                Container(
                  child: Text(
                      String.fromCharCode(mHotSearchList[index].hotattitude) +
                          "",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      )),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: mHotSearchTypeWidget,
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 0.5,
          color: Color(0xffE6E4E3),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        //  color: Colors.white,
        child: Scaffold(
      backgroundColor: Colors.white,
      body: NotificationListener(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification &&
                scrollNotification.depth == 0) {
              //滚动并且是列表滚动的时候
              listenScrollChangeTitle(scrollNotification.metrics.pixels);
            }
            return true;
          },
          child: Stack(
            children: <Widget>[
              NestedScrollView(headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                // These are the slivers that show up in the "outer" scroll view.
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      leading:
                          /*new IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {},
                      ),*/
                          new Container(
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
                      title: isShowBlackTitle ? Text('微博热搜') : Text(''),
                      centerTitle: true,
                      floating: false,
                      pinned: true,
                      snap: false,
                      primary: true,
                      expandedHeight: 210.0,
                      backgroundColor: Color(0xffF8F8F8),
                      elevation: 0,
                      //是否显示阴影，直接取值innerBoxIsScrolled，展开不显示阴影，合并后会显示
                      forceElevated: innerBoxIsScrolled,
                      actions: <Widget>[
                        new Container(
                          margin:
                              EdgeInsets.only(right: 10, top: 20, bottom: 10),
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
                          margin:
                              EdgeInsets.only(right: 10, top: 20, bottom: 10),
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
                                    Constant.ASSETS_IMG + 'hot_search_top.png',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: new Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              }, body: new Builder(builder: (BuildContext contexta) {
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            contexta)),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.only(top: 8, bottom: 5, left: 10),
                        color: Color(0xffEEEEEE),
                        child: Text(
                          "实时热点,每分钟更新一次",
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff333333)),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          // return mCommentWidget(index);
                          return mHotSearchItem(index);
                        },
                        childCount: mHotSearchList.length,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: 120,
                        color: Color(0xfffffff),
                      ),
                    ),
                  ],
                );
              })),
              Align(
                  //对齐底部
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        color: Color(0xffE7E7E7),
                        height: 1,
                      ),
                      Container(
                          child: Container(
                        color: Color(0xffF9F9F9),
                        height: 40,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Image.asset(
                                      Constant.ASSETS_IMG +
                                          'hot_search_bottom1.png',
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                      "热搜榜",
                                      style: TextStyle(
                                          color: Color(0xffE0905D),
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 30,
                              color: Color(0xffE7E7E7),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Image.asset(
                                      Constant.ASSETS_IMG +
                                          'hot_search_bottom2.png',
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                      "话题榜",
                                      style: TextStyle(
                                          color: Color(0xff333333),
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 30,
                              color: Color(0xffE7E7E7),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Image.asset(
                                      Constant.ASSETS_IMG +
                                          'hot_search_bottom3.png',
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                      "要闻榜",
                                      style: TextStyle(
                                          color: Color(0xff333333),
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                    ],
                  )),
            ],
          )),
    ));
  }
}
