import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';

//话题详情页
class TopicDetailPage extends StatefulWidget {
  String mTitle;
  String mImg;
  String mReadCount;
  String mDiscussCount;
  String mHost;

  TopicDetailPage(
      this.mTitle, this.mImg, this.mReadCount, this.mDiscussCount, this.mHost);

  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

final List<String> _tabs = [
  '综合',
  '实时',
  '热门',
  '视频',
  '问答',
  '图片',
  '同城',
];

class _TopicDetailPageState extends State<TopicDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        Constant.ASSETS_IMG + 'icon_back.png',
                        width: 23.0,
                        height: 23.0,
                      ))),
              Expanded(
                child: Container(
                    child: Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 15),
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      decoration: BoxDecoration(
                        color: Color(0xffE4E2E8),
                        borderRadius: BorderRadius.all(
                          //圆角
                          Radius.circular(5.0),
                        ),
                      ),
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              margin:
                                  EdgeInsets.only(right: 10, top: 2, left: 10),
                              child: Image.asset(
                                Constant.ASSETS_IMG + 'find_top_search.png',
                                width: 16.0,
                                height: 16.0,
                              ),
                            ),
                            Text(
                              "#" + widget.mTitle + "#",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xffee565656)),
                            ),
                          ],
                        ),
                      )),
                )),
              )
            ],
          ),
          Expanded(
            child: DefaultTabController(
              length: _tabs.length, // This is the number of tabs.
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
                            child: Container(
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 130,
                                    child: Image.asset(
                                      Constant.ASSETS_IMG +
                                          'topic_detail_top.webp',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 30),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10, left: 15, right: 15),
                                          width: 70,
                                          height: 70,
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              1.0),
                                                      shape: BoxShape.rectangle,
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              widget.mImg),
                                                          fit: BoxFit.cover))),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              new Text(
                                                "#" + widget.mTitle + "#",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Container(
                                                child: new Text(
                                                  widget.mReadCount +
                                                      "阅读   " +
                                                      widget.mDiscussCount +
                                                      "讨论   详情>",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                margin: EdgeInsets.only(
                                                    top: 8, right: 15),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 3, right: 15),
                                                child: new Text(
                                                  "主持人:" + widget.mHost,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                      )),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      floating: true,
                      delegate: _SliverAppBarDelegate(
                          minHeight: 50.0,
                          maxHeight: 50.0,
                          child: Column(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    color: Colors.white,
                                    child: TabBar(
                                        isScrollable: true,
                                        indicatorColor: Color(0xffFF3700),
                                        indicator: UnderlineTabIndicator(
                                            borderSide: BorderSide(
                                                color: Color(0xffFF3700),
                                                width: 2),
                                            insets: EdgeInsets.only(bottom: 7)),
                                        labelColor: Color(0xff333333),
                                        unselectedLabelColor: Color(0xff666666),
                                        labelStyle: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700),
                                        unselectedLabelStyle:
                                            TextStyle(fontSize: 16.0),
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        tabs: [
                                          new Tab(
                                            text: _tabs[0],
                                          ),
                                          new Tab(
                                            text: _tabs[1],
                                          ),
                                          new Tab(
                                            text: _tabs[2],
                                          ),
                                          new Tab(
                                            text: _tabs[3],
                                          ),
                                          new Tab(
                                            text: _tabs[4],
                                          ),
                                          new Tab(
                                            text: _tabs[5],
                                          ),
                                          new Tab(
                                            text: _tabs[6],
                                          ),
                                        ]),
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 5,
                                    bottom: 5,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          right: 5, top: 5, bottom: 5),
                                      color: Colors.white,
                                      child: Image.asset(
                                        Constant.ASSETS_IMG +
                                            'topic_detail_add.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                  )
                                ],
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
                body: TabBarView(
                  // These are the contents of the tab views, below the tabs.
                  children: _tabs.map((String name) {
                    return SafeArea(
                      top: false,
                      bottom: false,
                      child: Builder(
                        // This Builder is needed to provide a BuildContext that is "inside"
                        // the NestedScrollView, so that sliverOverlapAbsorberHandleFor() can
                        // find the NestedScrollView.
                        builder: (BuildContext context) {
                          return CustomScrollView(
                            // The "controller" and "primary" members should be left
                            // unset, so that the NestedScrollView can control this
                            // inner scroll view.
                            // If the "controller" property is set, then this scroll
                            // view will not be associated with the NestedScrollView.
                            // The PageStorageKey should be unique to this ScrollView;
                            // it allows the list to remember its scroll position when
                            // the tab view is not on the screen.
                            key: PageStorageKey<String>(name),
                            slivers: <Widget>[
                              /*SliverOverlapInjector(
                            // This is the flip side of the SliverOverlapAbsorber above.
                            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                          ),*/
                              SliverPadding(
                                padding: const EdgeInsets.all(8.0),
                                // In this example, the inner scroll view has
                                // fixed-height list items, hence the use of
                                // SliverFixedExtentList. However, one could use any
                                // sliver widget here, e.g. SliverList or SliverGrid.
                                sliver: SliverFixedExtentList(
                                  // The items in this example are fixed to 48 pixels
                                  // high. This matches the Material Design spec for
                                  // ListTile widgets.
                                  itemExtent: 48.0,
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      // This builder is called for each child.
                                      // In this example, we just number each list item.
                                      return ListTile(
                                        title: Text('Item $index'),
                                      );
                                    },
                                    // The childCount of the SliverChildBuilderDelegate
                                    // specifies how many children this inner list
                                    // has. In this example, each tab has a list of
                                    // exactly 30 items, but this is arbitrary.
                                    childCount: 30,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
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
