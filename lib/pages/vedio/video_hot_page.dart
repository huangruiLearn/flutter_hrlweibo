import "package:dio/dio.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/model/VideoModel.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:flutter_hrlweibo/util/date_util.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_hrlweibo/widget/loadrefreshlist/my_refresh_load_sliverlist.dart';

class VideoHotPage extends StatefulWidget {
  @override
  _VideoHotPageState createState() => _VideoHotPageState();
}

class _VideoHotPageState extends State<VideoHotPage>    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<String> mBannerAdList = [];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FormData params = FormData.fromMap({'pageNum': "1", 'pageSize': "10"});
    DioManager.instance.post(ServiceUrl.getVideoHotBannerAdList, params,
            (data) {
          List<String> list = [];
          data.forEach((data) {
            list.add(data.toString());
          });
          mBannerAdList = [];
          mBannerAdList = list;
          setState(() {});
        }, (error) {});
  }



  Widget mCenterBannerItemWidegt(String mUrl) {
    return Container(
      child: ClipRRect(
        child: FadeInImage.assetNetwork(
          fit: BoxFit.cover,
          placeholder: Constant.ASSETS_IMG + 'img_default2.png',
          image: mUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child:
      HrlSliverList<VideoModel>(
          headView: mHead(),
          centerWidget:centerWidget(),
          itemBuilder: _itemBuilder,
          pageFuture: (pageIndex) => getListData(pageIndex)),

    );
  }

  Future<List<VideoModel>> getListData(pageNum) async {
    await Future.delayed(Duration(seconds: 3));

    FormData params =   FormData.fromMap({'pageNum': pageNum.toString(), 'pageSize': "10"});
    Map<String, dynamic> json = await DioManager.instance
        .post (ServiceUrl.getVideoHotList, params);
    List<VideoModel> list = [];
    json ['list'].forEach((data) {
      list.add(VideoModel.fromJson(data));
    });

    return list;
  }


  Widget centerWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Container(
        height: 120,
        child: new Swiper(
          outer: false,
          pagination: new SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                size: 7,
                space: 5,
                activeSize: 7,
                color: Color(0xF0F0F0),
                activeColor: Color(0xD8D8D8),
              ),
              margin: EdgeInsets.all(0)),
          itemBuilder: (c, i) {
            return mCenterBannerItemWidegt(mBannerAdList[i]);
          },
          itemCount: mBannerAdList.length,
        ),
      ),
    );
  }


  Widget _itemBuilder(BuildContext context, VideoModel mModel, _) {
    return getContentItem(context, mModel);
  }

  SliverToBoxAdapter mHead() {
    return SliverToBoxAdapter(
      child: Row(
        children: <Widget>[
          new Expanded(
            child: InkWell(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    Constant.ASSETS_IMG + 'video_hot_top1.png',
                    width: 45.0,
                    height: 45.0,
                  ),
                  Text(
                    "排行榜",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),
            flex: 1,
          ),
          new Expanded(
            child: InkWell(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    Constant.ASSETS_IMG + 'video_hot_type2.png',
                    width: 45.0,
                    height: 45.0,
                  ),
                  Text(
                    "每周必看",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),
            flex: 1,
          ),
          new Expanded(
            child: InkWell(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    Constant.ASSETS_IMG + 'video_hot_type3.png',
                    width: 45.0,
                    height: 45.0,
                  ),
                  Text(
                    "宝藏博主",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),
            flex: 1,
          ),
          new Expanded(
            child: InkWell(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    Constant.ASSETS_IMG + 'video_hot_type4.png',
                    width: 45.0,
                    height: 45.0,
                  ),
                  Text(
                    "更多频道",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }


  Widget getContentItem(BuildContext context, VideoModel mModel) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 100,
            width: MediaQuery
                .of(context)
                .size
                .width * 3 / 8,
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 3 / 8,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder:
                      AssetImage(Constant.ASSETS_IMG + 'img_default.png'),
                      image: NetworkImage(
                        mModel.coverimg,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    child: new Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,

                          children: <Widget>[
                            Spacer(),
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Text(
                                  DateUtil.getFormatTime4(mModel.videotime)
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 40,
                  child: Text(mModel.introduce,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, color: Colors.black)),
                  //  margin: EdgeInsets.only(left: 60),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.all(2),
                  child: Text(
                    mModel.recommengstr,
                    style: TextStyle(fontSize: 11, color: Color(0xffFB9213)),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                      //圆角
                      Radius.circular(5.0),
                    ),
                    color: Color(0xffFEF5E2),
                  ),
                ),
                Container(
                  child: Container(
                      margin: EdgeInsets.only(top: 2),
                      child: Text(
                        "@" + mModel.username,
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          child: Text(
                            mModel.playnum.toString(),
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          )),
                      Container(
                          child: Text(
                            "次观看 · ",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Center(
                            child: Text(
                              DateUtil.getFormatTime(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      mModel.createtime))
                                  .toString(),
                              style:
                              TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }


}
