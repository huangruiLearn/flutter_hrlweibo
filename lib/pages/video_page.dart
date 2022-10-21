import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/http/dio_manager.dart';
import 'package:flutter_hrlweibo/model/videocategory.dart';
import 'package:flutter_hrlweibo/model/VedioCategoryList.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'vedio/video_hot_page.dart';
import 'vedio/video_recommend_page.dart';
import 'vedio/video_smallvideo_page.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with TickerProviderStateMixin {
  TabController? mTabController;
  List<VedioCategory> mTabList =  [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mTabList.add(new VedioCategory(id: 1, cname: "推荐"));
    mTabList.add(new VedioCategory(id: 2, cname: "热门"));
    mTabList.add(new VedioCategory(id: 3, cname: "小视频"));
    mTabController = TabController(length: mTabList.length, vsync: this);
    DioManager.instance.post(ServiceUrl.getVedioCategory, null, (data) {
      List<VedioCategory> mList = VedioCategoryList.fromJson(data).data;
      setState(() {
        mTabList = mList;
        mTabController = TabController(length: mTabList.length, vsync: this);
      });
    }, (error) {
      //ToastUtil.show(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //color: MyColorRes.bgTagColor,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 50,
              child: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  labelColor: Color(0xffF78005),
                  unselectedLabelColor: Color(0xff666666),
                  labelStyle:TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700),
                  unselectedLabelStyle: TextStyle(fontSize: 16.0),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: mTabController,
                  tabs: mTabList.map((value) {
                    return Text(value.cname);
                  }).toList()),
            ),
            Container(
                child: Center(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 10, right: 10),
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 5, top: 2),
                          child: Image.asset(
                            Constant.ASSETS_IMG + 'find_top_search.png',
                            width: 12.0,
                            height: 15.0,
                          ),
                        ),
                        Text(
                          "搜你想看的视频",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14, color: Color(0xffee565656)),
                        ),
                      ],
                    ),
                  ))),
            )),
            Expanded(
              flex: 1,
              child: TabBarView(
                children: <Widget>[
                  VideoRecommendPage(),
                  VideoHotPage(),
                  VideoSmallVideoPage(),
                ],
                controller: mTabController,
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TabController>('mTabController', mTabController));
  }
}
