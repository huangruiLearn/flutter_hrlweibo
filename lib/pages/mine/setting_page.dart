import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:flutter_hrlweibo/util/toast_util.dart';
import 'package:path/path.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

//头像布局
class SettingHead extends StatelessWidget {
  final VoidCallback onPressed;

  SettingHead({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
          onTap: onPressed,
          child: Column(
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: new IntrinsicHeight(
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Text('头像管理',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                        ),
                      ),
                      new Container(
                        margin: new EdgeInsets.symmetric(horizontal: 5.0),
                        child: new CircleAvatar(
                          backgroundImage:
                              new NetworkImage(UserUtil.getUserInfo().headurl),
                          radius: 20.0,
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.only(left: 5.0, right: 15),
                        child: new InkWell(
                          child: Image.asset(
                            Constant.ASSETS_IMG + "icon_right_arrow.png",
                            width: 15,
                            height: 15,
                          ),
                          onTap: () {
                            // TODO(implement)
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 0.5,
                color: Colors.black12,
                //  margin: EdgeInsets.only(left: 60),
              ),
            ],
          )),
    );
  }
}

//普通条目布局
class SettingCommon extends StatelessWidget {
  final VoidCallback onPressed;

  const SettingCommon({this.title, this.content, this.onPressed});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: new InkWell(
          onTap: onPressed,
          child: Column(
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: new IntrinsicHeight(
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Text(title,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                        ),
                      ),
                      new Container(
                        margin: new EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(content,
                            style:
                                TextStyle(fontSize: 14, color: Colors.black)),
                      ),
                      new Container(
                        margin: const EdgeInsets.only(left: 5.0, right: 15),
                        child: Image.asset(
                          Constant.ASSETS_IMG + "icon_right_arrow.png",
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 0.5,
                color: Colors.black12,
                //  margin: EdgeInsets.only(left: 60),
              ),
            ],
          ),
        ));
  }
}

//, elevation: 0.5
class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
    Constant.eventBus.on<ChangeInfoEvent>().listen((event) {
      setState(() {
        print("接收更换个人信息的消息");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //  color: Colors.white,
      child: Material(
          child: Scaffold(
        appBar: AppBar(
            title: Text(
              '设置',
              style: TextStyle(fontSize: 16),
            ),
            elevation: 0.5),
        body: Container(
          color: Color(0xffF2F2F2),
          child: ListView(
            children: <Widget>[
              SettingHead(onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return HeadChooseWidget(
                          chooseImgCallBack: (File mHeadFile) {
                        FormData formData = FormData.fromMap({
                          "userId": UserUtil.getUserInfo().id,
                          "headFile": MultipartFile.fromFileSync(mHeadFile.path)
                        });
                        request(ServiceUrl.updateHead, formData: formData)
                            .then((val) {
                          int code = val['status'];
                          if (code == 200) {
                            String mUrl = val['data'];
                            print("返回的头像的url:${mUrl}");
                            UserUtil.saveUserHeadUrl(mUrl);
                            ToastUtil.show('提交成功!');
                            setState(() {});
                          } else {
                            String msg = val['msg'];
                            ToastUtil.show(msg);
                          }
                        });
                      });
                    });
              }),
              SettingCommon(
                  title: "用户昵称",
                  content: UserUtil.getUserInfo().nick,
                  onPressed: () {
                    Routes.navigateTo(context, '${Routes.changeNickNamePage}');
                  }),
              SettingCommon(
                  title: "个性签名",
                  content: "",
                  onPressed: () {
                    Routes.navigateTo(context, '${Routes.changeDescPage}');
                  }),
              SettingCommon(
                  title: "生日",
                  content: "",
                  onPressed: () {
                    //  ToastUtil.show('暂未开发!');
                  }),
              SettingCommon(
                  title: "所在区域",
                  content: "",
                  onPressed: () {
                    // ToastUtil.show('暂未开发!');
                  }),
              Container(
                height: 30,
                color: Color(0xffF2F2F2),
                //  margin: EdgeInsets.only(left: 60),
              ),
              SettingCommon(
                title: "意见反馈",
                content: "",
                onPressed: () {
                  Routes.navigateTo(context, '${Routes.feedbackPage}');
                },
              ),
              SettingCommon(title: "关于微博", content: ""),
              SettingCommon(title: "清理缓存", content: ""),
              Container(
                height: 30,
                color: Color(0xffF2F2F2),
                //  margin: EdgeInsets.only(left: 60),
              ),
              Material(
                color: Colors.white,
                child: InkWell(
                    onTap: () {
                      //Routes  .navigateTo(context, '${Routes.settingPage}');
                      showDialog(
                        context: context,
                        barrierDismissible: true, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text('退出登录?'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('确定'),
                                onPressed: () {
                                  UserUtil.loginout();
                                  Navigator.of(context).pop();
                                  Routes.navigateTo(
                                      context, '${Routes.loginPage}',
                                      clearStack: true,
                                      transition: TransitionType.fadeIn);
                                },
                              ),
                              FlatButton(
                                child: Text('取消'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                            backgroundColor: Colors.white,
                            elevation: 20,
                            // 设置成 圆角
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                      ),
                      child: Center(
                        child: Text('退出微博',
                            style: TextStyle(fontSize: 14, color: Colors.red)),
                      ),
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
