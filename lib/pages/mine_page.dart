import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hrlweibo/public.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  void initState() {
    super.initState();
    if (UserUtil.isLogin()) {
       FormData params = FormData.fromMap({
        'muserId': UserUtil.getUserInfo().id,
        'otheruserId': UserUtil.getUserInfo().id,
      });
      DioManager.instance.post(ServiceUrl.getUserInfo, params, (data) {
        UserUtil.saveUserInfo(data);
        setState(() {});
      }, (error) {});
    }
  }

  //TODO
   @override
  void deactivate() {
    super.deactivate();
     var isTopRoute = ModalRoute.of(context)!.isCurrent;
    if (isTopRoute) {
       if (UserUtil.isLogin()) {
        FormData params = FormData.fromMap({
          'muserId': UserUtil.getUserInfo().id,
          'otheruserId': UserUtil.getUserInfo().id,
        });
        DioManager.instance.post(ServiceUrl.getUserInfo, params, (data) {
          UserUtil.saveUserInfo(data);
          SchedulerBinding.instance
              .addPostFrameCallback((_) => setState(() {}));
        }, (error) {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          color: Color(0xffEEEEEE),
          child: Column(
            children: <Widget>[
              _buildTitle(),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.only(top: 0),
                children: <Widget>[
                  _buildMyInfo(),
                  _buildMoreActions(),
                  _buildBottom(),
                ],
              )),
            ],
          )),
    );
  }

  //顶部标题
  Widget _buildTitle() {
    return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 15),
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  Constant.ASSETS_IMG + 'icon_mine_add_friends.png',
                  width: 25.0,
                  height: 25.0,
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: new Text(
                  '我',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        child: InkWell(
                          child: Image.asset(
                            Constant.ASSETS_IMG + 'icon_mine_qrcode_2.png',
                            width: 25.0,
                            height: 25.0,
                          ),
                          onTap: () {},
                        ),
                      ),
                      Container(
                        child: InkWell(
                          child: Image.asset(
                            Constant.ASSETS_IMG + 'icon_mine_setting.png',
                            width: 25.0,
                            height: 25.0,
                          ),
                          onTap: () {
                            Routes.navigateTo(context, '${Routes.settingPage}');
                          },
                        ),
                      )
                    ],
                  )),
              flex: 1,
            ),
          ],
        ));
  }

  Widget  mHeadWidget() {
    return (UserUtil.getUserInfo() == null ||
            UserUtil.getUserInfo().headurl == null)
        ? CircleAvatar(
            //头像半径
            radius: 25,
            //头像图片 -> NetworkImage网络图片，AssetImage项目资源包图片, FileImage本地存储图片
            backgroundImage:
                AssetImage(Constant.ASSETS_IMG + "ic_avatar_default.png"),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: FadeInImage(
              fit: BoxFit.cover,
              placeholder: AssetImage(Constant.ASSETS_IMG + 'img_default.png'),
              image: NetworkImage(UserUtil.getUserInfo().headurl??""),
            ),
          );
  }

  //我的信息
  Widget _buildMyInfo() {
    return Container(
      color: Colors.white,
      //
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          Material(
              //水波纹按压效果
              color: Colors.white,
              child: InkWell(
                child: Container(
                  padding: EdgeInsets.only(top: 12, bottom: 15),
                  child: Row(
                    children: <Widget>[
                      Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.only(left: 20, right: 15),
                          child: UserUtil.getUserInfo().isvertify  == 0
                              ? mHeadWidget()
                              :  Stack(
                                  children: <Widget>[
                                    mHeadWidget(),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        child: Image.asset(
                                          (UserUtil.getUserInfo().isvertify ==
                                                  1)
                                              ? Constant.ASSETS_IMG +
                                                  'home_vertify.webp'
                                              : Constant.ASSETS_IMG +
                                                  'home_vertify2.webp',
                                          width: 16.0,
                                          height: 16.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Center(
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0.0),
                                      child: Text(UserUtil.getUserInfo().nick??"null",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: UserUtil.getUserInfo()
                                                          .ismember ==
                                                      0
                                                  ? Colors.black
                                                  : Color(0xffF86119)))),
                                ),
                                Center(
                                  child: UserUtil.getUserInfo().ismember == 0
                                      ? new Container()
                                      : Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Image.asset(
                                            Constant.ASSETS_IMG +
                                                'home_memeber.webp',
                                            width: 15.0,
                                            height: 13.0,
                                          ),
                                        ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              (UserUtil.getUserInfo() == null ||
                                      UserUtil.getUserInfo().decs == null)
                                  ? ""
                                  : UserUtil.getUserInfo().decs??"null",
                              style: TextStyle(
                                  letterSpacing: 0,
                                  color: Colors.grey,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Image.asset(
                                  Constant.ASSETS_IMG + 'icon_right_arrow.png',
                                  width: 15.0,
                                  height: 30.0,
                                ),
                              )))
                    ],
                  ),
                ),
                onTap: () {
                  Routes.navigateTo(context, Routes.personinfoPage, params: {
                    'userid': UserUtil.getUserInfo().id,
                  });
                },
              )),
          Container(
            height: 0.5,
            color: Color(0xffE2E2E2),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Material(
                  //水波纹按压效果
                  color: Colors.white,
                  child: InkWell(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            '15',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '微博',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      print("点击关注");
                    },
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Material(
                  //水波纹按压效果
                  color: Colors.white,
                  child: InkWell(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            UserUtil.getUserInfo().followCount??"null",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '关注',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      print("点击关注");
                      Routes.navigateTo(context, Routes.personMyFollowPage,
                          transition: TransitionType.fadeIn);
                    },
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Material(
                  //水波纹按压效果
                  color: Colors.white,
                  child: InkWell(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            UserUtil.getUserInfo().fanCount??"null",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '粉丝',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Routes.navigateTo(context, Routes.personFanPage,
                          transition: TransitionType.fadeIn);
                    },
                  ),
                ),
                flex: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  //更多功能
  Widget _buildMoreActions() {
    return Container(
        //padding: EdgeInsets.only(top: 10, bottom: 10),
        margin: EdgeInsets.only(top: 10),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Material(
                    //水波纹按压效果
                    color: Colors.white,
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Image.asset(
                              Constant.ASSETS_IMG + "icon_mine_pic.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              '我的相册',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        print("点击关注");
                      },
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Material(
                    //水波纹按压效果
                    color: Colors.white,
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Image.asset(
                              Constant.ASSETS_IMG + "icon_mine_story.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              '我的故事',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        print("点击关注");
                      },
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Material(
                    //水波纹按压效果
                    color: Colors.white,
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Image.asset(
                              Constant.ASSETS_IMG + "icon_mine_zan.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              '我的赞',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        print("点击关注");
                      },
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Material(
                    //水波纹按压效果
                    color: Colors.white,
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Image.asset(
                              Constant.ASSETS_IMG + "icon_mine_fans.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              '我的粉丝',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Routes.navigateTo(context, Routes.personFanPage,
                            transition: TransitionType.fadeIn);
                      },
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Material(
                    //水波纹按压效果
                    color: Colors.white,
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Image.asset(
                              Constant.ASSETS_IMG + "icon_mine_wallet.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              '微博钱包',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        print("点击关注");
                      },
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Material(
                    //水波纹按压效果
                    color: Colors.white,
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Image.asset(
                              Constant.ASSETS_IMG + "icon_mine_gchoose.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              '微博优选',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        print("点击关注");
                      },
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Material(
                    //水波纹按压效果
                    color: Colors.white,
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Image.asset(
                              Constant.ASSETS_IMG + "icon_mine_fannews.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              '粉丝头条',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        print("点击关注");
                      },
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Material(
                    //水波纹按压效果
                    color: Colors.white,
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Image.asset(
                              Constant.ASSETS_IMG +
                                  "icon_mine_customservice.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              '客服中心',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        print("点击关注");
                      },
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          ],
        ));
  }

  _buildBottom() {
    return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: <Widget>[
            Material(
              color: Colors.white,
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        Constant.ASSETS_IMG + "icon_mine_freenet.png",
                        width: 25,
                        height: 25,
                      ),
                      Expanded(
                          child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                '免流量',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ))),
                      Image.asset(
                        Constant.ASSETS_IMG + "icon_right_arrow.png",
                        width: 15,
                        height: 15,
                      ),
                    ],
                  ),
                ),
                onTap: () {},
              ),
            ),
            Container(
              height: 0.5,
              color: Color(0xffE2E2E2),
            ),
            Material(
              color: Colors.white,
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        Constant.ASSETS_IMG + "icon_mine_sport.png",
                        width: 25,
                        height: 25,
                      ),
                      Expanded(
                          child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                '微博运动',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ))),
                      Image.asset(
                        Constant.ASSETS_IMG + "icon_right_arrow.png",
                        width: 15,
                        height: 15,
                      ),
                    ],
                  ),
                ),
                onTap: () {},
              ),
            ),
            Container(
              height: 0.5,
              color: Color(0xffE2E2E2),
            ),
            Material(
              color: Colors.white,
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        Constant.ASSETS_IMG + "icon_mine_draft.png",
                        width: 25,
                        height: 25,
                      ),
                      Expanded(
                          child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                '草稿箱',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ))),
                      Image.asset(
                        Constant.ASSETS_IMG + "icon_right_arrow.png",
                        width: 15,
                        height: 15,
                      ),
                    ],
                  ),
                ),
                onTap: () {},
              ),
            )
          ],
        ));
  }
}
