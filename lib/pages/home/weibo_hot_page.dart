import 'package:flutter/material.dart';
import 'weibo_list_page.dart';

class WeiBoHotPage extends StatefulWidget {
  @override
  _WeiBoHotPageState createState() => _WeiBoHotPageState();
}

class _WeiBoHotPageState extends State<WeiBoHotPage>
    with TickerProviderStateMixin {
  final List<String> _tabValues = ['推荐', '附近', '榜单', '明星', '搞笑', '社会', '测试'];
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: _tabValues.length);
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
                color: Color(0xffffffff),
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
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: <Widget>[
                WeiBoListPage(mCatId: "1"),
                WeiBoListPage(mCatId: "2"),
                WeiBoListPage(mCatId: "3"),
                WeiBoListPage(mCatId: "4"),
                WeiBoListPage(mCatId: "5"),
                WeiBoListPage(mCatId: "999999"),
                WeiBoListPage(mCatId: "10"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
