import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/model/VideoModel.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:flutter_hrlweibo/util/date_util.dart';
import 'package:flutter_hrlweibo/widget/loadrefreshlist/my_refresh_load_slivergrid.dart';

class VideoRecommendPage extends StatefulWidget {
  @override
  _VideoRecommendPageState createState() => _VideoRecommendPageState();
}

class _VideoRecommendPageState extends State<VideoRecommendPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double mGridItemHeight = 200;
    final double mGridItemWidth = size.width / 2;

    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
      child: HrlSliverGrid<VideoModel>(
          mGridItemHeight: mGridItemHeight,
          mGridItemWidth: mGridItemWidth,
          pageSize: 10,
          itemBuilder: _itemBuilder,
          pageFuture: (pageIndex) => getListData(pageIndex)),
    );
  }

  Future<List<VideoModel>> getListData(pageNum) async {
   /* await Future.delayed(Duration(seconds: 3));
    if (pageNum == 3) {
      print("网路:" + pageNum);
    }
*/
    FormData params =
        FormData.fromMap({'pageNum': pageNum.toString(), 'pageSize': "10"});
    Map<String, dynamic> json = await DioManager.instance
        .post(ServiceUrl.getVideoRecommendList, params);
    List<VideoModel> list = [];
    json['list'].forEach((data) {
      list.add(VideoModel.fromJson(data));
    });

    return list;
  }

  Widget _itemBuilder(BuildContext context, VideoModel mModel, _) {
    return InkResponse(
      highlightColor: Colors.transparent,
      onTap: () {
        Routes.navigateTo(context, Routes.videoDetailPage,
            params: {
              'video': convert.jsonEncode(mModel),
            },
            transition: TransitionType.fadeIn);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder:
                          AssetImage(Constant.ASSETS_IMG + 'img_default2.png'),
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
                        Container(
                          margin: EdgeInsets.only(left: 5, right: 3),
                          child: Image.asset(
                            Constant.ASSETS_IMG + 'video_play.png',
                            width: 15.0,
                            height: 15.0,
                          ),
                        ),
                        Text(mModel.playnum.toString(),
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.white)),
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
          Container(
            height: 40,
            margin: EdgeInsets.only(top: 5),
            child: Text(mModel.introduce,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.0, color: Colors.black)),
            //  margin: EdgeInsets.only(left: 60),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    (mModel.recommengstr == "null")
                        ? ((mModel.tag == "null")
                            ? new Container()
                            : Text(
                                mModel.tag.toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ))
                        : Container(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              mModel.recommengstr,
                              style:
                                  TextStyle(fontSize: 11, color: Colors.orange),
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
                  ],
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 3),
                  child: Image.asset(
                    Constant.ASSETS_IMG + 'video_ver_more.png',
                    width: 15.0,
                    height: 15.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
