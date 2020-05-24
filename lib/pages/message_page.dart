import 'package:flutter/material.dart';

import 'message/message_dynamic_page.dart';
import 'message/message_msg_page.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
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

class TabBarWidget extends StatefulWidget {
  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  final List<String> _tabValues = [
    '动态',
    '消息',
  ];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabValues.length, //Tab页数量
      vsync: ScrollableState(), //动画效果的异步处理
    );
    _tabController.addListener(() {
      print("_tabController.index的值:" + _tabController.index.toString());
      setState(() {
        // print("_tabController.index的值:"+_tabController.index.toString());
      });
    });
  }

  //当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color(0xffffffff),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
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
                    controller: _tabController,
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
                alignment: Alignment.centerLeft,
                child: new Container(
                  margin: EdgeInsets.only(left: 15),
                  child: (_tabController.index == 1)
                      ? Text(
                          "发现群",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        )
                      : new Container(),
                ),
              ),
              new Align(
                alignment: Alignment.centerRight,
                child: new IconButton(
                  icon: new Image.asset("assets/images/message_setting.webp",
                      width: 30.0, height: 30.0),
                  onPressed: () {
                    // Routes .navigateTo(context, '${Routes.weiboPublishPage}');
                  },
                ),
              ),
            ],
          ),
          new Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                new MessageDynamicPage(),
                new MessageMsgPage()
              ],
            ),
          )
        ],
      ),
    ));
  }
}
