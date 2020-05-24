import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/public.dart';

class FollowPage extends StatefulWidget {
  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  TabController mTabcontroller;
  ScrollController mListController = new ScrollController();

  @override
  void initState() {
    super.initState();
    mTabcontroller =
        TabController(vsync: ScrollableState(), initialIndex: 0, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFAFAFA),
        leading: IconButton(
            iconSize: 30,
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          '关注',
          style: TextStyle(fontSize: 16),
        ),
        elevation: 0.5,
        centerTitle: true,
        actions: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 15),
              child: InkWell(
                child: Center(
                  child: Text('发现用户'),
                ),
                onTap: () {},
              )),
        ],
      ),
      body: Container(
        color: Color(0xffeeeeee),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 70),
              child: TabBar(
                tabs: [
                  Tab(
                    text: "推荐",
                  ),
                  Tab(
                    text: "关注的人",
                  ),
                ],
                controller: mTabcontroller,
                //配置控制器
                //  isScrollable: true,
                indicatorColor: Colors.deepOrange,
                indicatorWeight: 2,
                indicatorSize: TabBarIndicatorSize.label,
                //indicatorPadding: EdgeInsets.only(bottom: 10.0),
                //labelPadding: EdgeInsets.only(left: 20),
                labelColor: Color(0xff333333),
                labelStyle: TextStyle(
                  fontSize: 16.0,
                ),
                unselectedLabelColor: Color(0xff666666),
                unselectedLabelStyle: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: TabBarView(
                controller: mTabcontroller, //配置控制器
                children: <Widget>[
                  FFRecommendPage(),
                  FollowListPage(),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
