import "package:dio/dio.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/model/VideoModel.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:flutter_hrlweibo/util/date_util.dart';
import 'package:flutter_hrlweibo/widget/loadrefreshlist/my_refresh_load_slivergrid.dart';

class VideoSmallVideoPage extends StatefulWidget {
  @override
  _VideoSmallVideoPageState createState() => _VideoSmallVideoPageState();
}

class _VideoSmallVideoPageState extends State<VideoSmallVideoPage>    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double mGridItemHeight = 200;
    final double mGridItemWidth = size.width / 2;

    return Container(
      padding: EdgeInsets.only(top: 15),
      child:HrlSliverGrid<VideoModel>(
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
        .post(ServiceUrl.getVideoSmallList, params);
    List<VideoModel> list = [];
    json['list'].forEach((data) {
      list.add(VideoModel.fromJson(data));
    });

    return list;
  }

  Widget _itemBuilder(BuildContext context, VideoModel mModel, _) {
    return Container(
      //  height: 200,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              //  borderRadius: BorderRadius.circular(5),
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
                          style: TextStyle(fontSize: 14.0, color: Colors.white)),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Text(
                            DateUtil.getFormatTime4(mModel.videotime).toString(),
                            style: TextStyle(fontSize: 14.0, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );

  }



}
