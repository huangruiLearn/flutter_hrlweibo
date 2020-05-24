import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hrlweibo/pages/find_page.dart';
import 'package:flutter_hrlweibo/pages/message_page.dart';
import 'package:flutter_hrlweibo/public.dart';

import 'home_page.dart';
import 'mine_page.dart';
import 'video_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = ['首页', '视频', '发现', '消息', '我'];
  var currentPage;
  DateTime lastPopTime;

  /*
   * 根据选择获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 13.0, color: Colors.black));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 13.0, color: Colors.black));
    }
  }

  Image getTabImage(path) {
    return new Image.asset(path, width: 25.0, height: 25.0);
  }

  void initData() {
    tabImages = [
      [
        getTabImage('assets/images/tabbar_home.png'),
        getTabImage('assets/images/tabbar_home_highlighted.png')
      ],
      [
        getTabImage('assets/images/tabbar_video.png'),
        getTabImage('assets/images/tabbar_video_highlighted.png')
      ],
      [
        getTabImage('assets/images/tabbar_discover.png'),
        getTabImage('assets/images/tabbar_discover_highlighted.png')
      ],
      [
        getTabImage('assets/images/tabbar_message_center.png'),
        getTabImage('assets/images/tabbar_message_center_highlighted.png')
      ],
      [
        getTabImage('assets/images/tabbar_profile.png'),
        getTabImage('assets/images/tabbar_profile_highlighted.png')
      ],
    ];
  }

  final List<Widget> tabBodies = [
    HomePage(),
    VideoPage(),
    FindPage(),
    MessagePage(),
    MinePage()
  ];

  @override
  Widget build(BuildContext context) {
    initData();
    final List<BottomNavigationBarItem> bottomTabs = [
      BottomNavigationBarItem(icon: getTabIcon(0), title: getTabTitle(0)),
      BottomNavigationBarItem(icon: getTabIcon(1), title: getTabTitle(1)),
      BottomNavigationBarItem(icon: getTabIcon(2), title: getTabTitle(2)),
      BottomNavigationBarItem(icon: getTabIcon(3), title: getTabTitle(3)),
      BottomNavigationBarItem(icon: getTabIcon(4), title: getTabTitle(4)),
    ];

    return SafeArea(
      child: WillPopScope(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _tabIndex,
            items: bottomTabs,
            onTap: (index) async {
              setState(() {
                _tabIndex = index;
                currentPage = tabBodies[_tabIndex];
              });
            },
          ),
          body: IndexedStack(
            index: _tabIndex,
            children: tabBodies,
          ),
        ),
          onWillPop: ()   {
          // 点击返回键的操作
          if (lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
            lastPopTime = DateTime.now();
            ToastUtil.show('再按一次退出应用');
          } else {
            lastPopTime = DateTime.now();
            // 退出app
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }
        },
      ),
    );
  }
}
