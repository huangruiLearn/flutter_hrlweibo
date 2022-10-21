import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';
import 'package:flutter_hrlweibo/model/VideoModel.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:flutter_hrlweibo/routers/routers.dart';
import 'package:flutter_hrlweibo/util/date_util.dart';

class VideoDetailIntroPage extends StatefulWidget {
  VideoModel mVideo;

  VideoDetailIntroPage(this.mVideo);

  @override
  _VideoDetailIntroPageState createState() => _VideoDetailIntroPageState();
}

class _VideoDetailIntroPageState extends State<VideoDetailIntroPage> {
  bool mZiDongPlaySwitch = false;
  List<VideoModel> mRecommendVideoList =  [];

  Future getmRecommendVideoList() async {
    FormData params = FormData.fromMap({
      'videoid': widget.mVideo.id,
    });
    DioManager.instance
        .post(ServiceUrl.getVideoDetailRecommendList, params, (data) {
      mRecommendVideoList.clear();
      data.forEach((data) {
        mRecommendVideoList.add(VideoModel.fromJson(data));
      });

      setState(() {});
    }, (error) {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getmRecommendVideoList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _authorRow(context, widget.mVideo),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Text(
                    widget.mVideo.introduce,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: Text(
                    DateUtil.getFormatTime(DateTime.fromMillisecondsSinceEpoch(
                                widget.mVideo.createtime))
                            .toString() +
                        "   " +
                        widget.mVideo.playnum.toString() +
                        "次观看",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Row(
                    children: <Widget>[
                      new Expanded(
                        child: InkWell(
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                Constant.ASSETS_IMG +
                                    'video_detail_zhuanfa.png',
                                width: 25.0,
                                height: 25.0,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                child: Text(
                                  "转发",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
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
                                Constant.ASSETS_IMG + 'video_detail_zan.png',
                                width: 25.0,
                                height: 25.0,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                child: Text(
                                  "点赞",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
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
                                Constant.ASSETS_IMG + 'video_detail_share.png',
                                width: 25.0,
                                height: 25.0,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                child: Text(
                                  "分享",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
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
                                Constant.ASSETS_IMG +
                                    'video_detail_downlaod.png',
                                width: 27.0,
                                height: 27.0,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                child: Text(
                                  "下载",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "接下来播放",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      Spacer(),
                      Text(
                        "自动播放",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      new Switch(
                        value: this.mZiDongPlaySwitch,
                        activeColor: Colors.blue, // 激活时原点颜色
                        onChanged: (bool val) {
                          this.setState(() {
                            this.mZiDongPlaySwitch = !this.mZiDongPlaySwitch;
                          });
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return mRecommendVideoWidget(
                      mRecommendVideoList[index], index, context);
                },
                childCount: mRecommendVideoList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget mRecommendVideoWidget(
    VideoModel mModel, int index, BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: index == 0 ? 0 : 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10),
          height: 80,
          width: MediaQuery.of(context).size.width * 3 / 8,
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 3 / 8,
                height: 80,
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
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.white)),
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
                margin: EdgeInsets.only(top: 3),

                child: Text(mModel.introduce,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.0, color: Colors.black)),
                //  margin: EdgeInsets.only(left: 60),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: Text(
                      mModel.username.toString() + "  ",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )),
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

//发布者昵称头像布局
Widget _authorRow(BuildContext context, VideoModel mVideo) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 2.0),
    child: Row(
      children: <Widget>[
        InkWell(
          onTap: () {
            Routes.navigateTo(context, Routes.personinfoPage, params: {
              'userid': mVideo.userid.toString(),
            });
          },
          child: Container(
            margin: EdgeInsets.only(right: 5),
            child: mVideo.userisvertify == 0
                ? Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      image: DecorationImage(
                          image: NetworkImage(mVideo.userheadurl),
                          fit: BoxFit.cover),
                    ))
                : Stack(
                    children: <Widget>[
                      Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            image: DecorationImage(
                                image: NetworkImage(mVideo.userheadurl),
                                fit: BoxFit.cover),
                          )),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          child: Image.asset(
                            (mVideo.userisvertify == 1)
                                ? Constant.ASSETS_IMG + 'home_vertify.webp'
                                : Constant.ASSETS_IMG + 'home_vertify2.webp',
                            width: 15.0,
                            height: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Center(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                      child: Text(mVideo.username,
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.black))),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    padding: new EdgeInsets.only(
                        top: 2.0, bottom: 2.0, left: 3.0, right: 3.0),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 0.5),
                      borderRadius: new BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      '作者',
                      style: TextStyle(color: Colors.black, fontSize: 8),
                    ),
                  ),
                )
              ],
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 2.0, 0.0, 0.0),
                child: Text(mVideo.userfancount.toString() + "粉丝  " + "视频博主",
                    style:
                        TextStyle(color: Color(0xff808080), fontSize: 11.0))),
          ],
        ),
        Expanded(
          child: new Align(
              alignment: FractionalOffset.centerRight,
              child: GestureDetector(
                child: Container(
                  padding: new EdgeInsets.only(
                      top: 3.0, bottom: 3.0, left: 6.0, right: 6.0),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.orange),
                    borderRadius: new BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    '+ 关注',
                    style: TextStyle(color: Colors.orange, fontSize: 12),
                  ),
                ),
              )),
        )
      ],
    ),
  );
}
