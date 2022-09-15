import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/public.dart';

import 'home/weibo_follow_page.dart';
import 'home/weibo_hot_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          new Expanded(child: new TabBarWidget()),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

TabController? _controller;

class TabBarWidget extends StatefulWidget {
  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget>  with SingleTickerProviderStateMixin{
  final List<String> _tabValues = [
    '关注',
    '热门',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(

      length: _tabValues.length, //Tab页数量
      vsync:this,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 50,
                color: Color(0xffF9F9F9),
                //  color:Colors.red,
                alignment: Alignment.center,
                child: TabBar(
                    isScrollable: true,
                    indicatorColor: Color(0xffFF3700),
                    indicator: UnderlineTabIndicator(
                        borderSide:
                            BorderSide(color: Color(0xffFF3700), width: 2),
                        insets: EdgeInsets.only(bottom: 7)),
                    labelColor: Color(0xff333333),
                    unselectedLabelColor: Color(0xff666666),
                    labelStyle:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
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
                    ]),
              ),
              new Align(
                alignment: Alignment.topRight,
                child: new IconButton(
                  icon: new Image.asset("assets/images/ic_main_add.png",
                      width: 40.0, height: 40.0),
                  onPressed: () {
                    Routes.navigateTo(context, '${Routes.weiboPublishPage}');
                  },
                ),
              ),
            ],
          ),
          new Expanded(
            child: TabBarView(
              controller: _controller,
              children: <Widget>[new WeiBoFollowPage(), new WeiBoHotPage()],
            ),
          )
        ],
      ),
    ));
  }
}
