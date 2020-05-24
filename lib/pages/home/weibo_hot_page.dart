import 'package:flutter/material.dart';

import 'weibo_homelist_page.dart';

class WeiBoHotPage extends StatefulWidget {
  @override
  _WeiBoHotPageState createState() => _WeiBoHotPageState();
}

class _WeiBoHotPageState extends State<WeiBoHotPage> {
  final List<String> _tabValues = ['推荐', '附近', '榜单', '明星', '搞笑', '社会', '测试'];
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(
      length: _tabValues.length, //Tab页数量
      vsync: ScrollableState(), //动画效果的异步处理
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 0.5,
            color: Color(0xffBECBC2),
          ),
          Stack(
            children: <Widget>[
              Container(
                height: 45,
                // margin: EdgeInsets.only(top: 40.0),
                color: Color(0xffffffff),
                //  color:Colors.red,
                alignment: Alignment.center,
                child: TabBar(
                    isScrollable: true,
                    indicatorColor: Color(0xffffffff),
                    labelColor: Color(0xffFF3700),
                    unselectedLabelColor: Color(0xff666666),
                    labelStyle:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                    unselectedLabelStyle: TextStyle(fontSize: 16.0),
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
                      new Tab(
                        text: _tabValues[4],
                      ),
                      new Tab(
                        text: _tabValues[5],
                      ),
                      new Tab(
                        text: _tabValues[6],
                      ),
                    ]),
              ),
            ],
          ),
          Container(
            height: 0.5,
            color: Color(0xffBECBC2),
          ),
          new Expanded(
            child: TabBarView(
              controller: _controller,
              children: <Widget>[
                new WeiBoHomeListPager(mCatId: "1"),
                new WeiBoHomeListPager(mCatId: "2"),
                new WeiBoHomeListPager(mCatId: "3"),
                new WeiBoHomeListPager(mCatId: "4"),
                new WeiBoHomeListPager(mCatId: "5"),
                Center(
                  child: Text("暂无数据"),
                ),
                new WeiBoHomeListPager(mCatId: "10"),
                //  new WeiBoHomeListPager(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
