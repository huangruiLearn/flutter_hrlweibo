import "package:dio/dio.dart";
import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';
import 'package:flutter_hrlweibo/http/dio_manager.dart';
import 'package:flutter_hrlweibo/public.dart';
import 'package:flutter_hrlweibo/util/sp_util.dart';
import 'package:flutter_hrlweibo/util/toast_util.dart';
import 'package:provider/provider.dart';
import '../../widget/textfield/TextFieldAccount.dart';
import '../../widget/textfield/TextFieldPwd.dart';
import 'provider/login_provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginBtnProvider>(
      create: (_) => LoginBtnProvider(),
      child: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("loginpage build方法");
    //登录时保存软键盘高度,在聊天界面第一次弹出底部布局时使用
    // print("键盘高度2是:${MediaQuery.of(context).viewInsets.bottom}");
    //  final viewInsets = EdgeInsets.fromWindowPadding(WidgetsBinding.instance.window.viewInsets,WidgetsBinding.instance.window.devicePixelRatio);
    // print("键盘高度是:$viewInsets");
    // SpUtil.putDouble( Constant.SP_KEYBOARD_HEGIHT, MediaQuery.of(context).viewInsets.bottom);
    return SafeArea(
      child: Material(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const TitleWidget(),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20.0, top: 30.0, bottom: 20),
                      child: Text(
                        "请输入账号密码",
                        style: TextStyle(fontSize: 24.0, color: Colors.black),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: AccountEditText(
                        contentStrCallBack: (content) {
                          context
                              .read<LoginBtnProvider>()
                              .setInputAccount(content);
                        },
                      ),
                    ),
                    //),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: PwdEditText(
                        contentStrCallBack: (content) {
                          context.read<LoginBtnProvider>().setInputPwd(content);
                        },
                      ),
                    ),
                    LoginBtn(),
                    RegistForgetWidget(),
                    OtherLoginWidget(),
                  ],
                ),
              ),
            )),
      ),
      // )
    );
  }
}

class RegistForgetWidget extends StatelessWidget {
  const RegistForgetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("RegistForgetWidget的build方法");
     return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, //子组件的排列方式为主轴两端对齐
      children: <Widget>[
        InkWell(
          child: Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 3),
              child: Text(
                "注册",
                style: TextStyle(fontSize: 13.0, color: Color(0xff6B91BB)),
              )),
          onTap: () {},
        ),
        InkWell(
          child: Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 3),
              child: Text(
                "忘记密码",
                style: TextStyle(fontSize: 13.0, color: Color(0xff6B91BB)),
              )),
          onTap: () {
            /* Routes.navigateTo(context, Routes.chatPage,
                transition: TransitionType.fadeIn);*/
          },
        ),
      ],
    );
  }
}

class OtherLoginWidget extends StatelessWidget {
  const OtherLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("OtherLoginWidget的build方法");
     return Container(
        margin: EdgeInsets.only(top: 150),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    color: Color(0xffEAEAEA),
                    height: 1,
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Text(
                        '其他登陆方式',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xff999999)),
                      ),
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    color: Color(0xffEAEAEA),
                    height: 1,
                  ),
                  flex: 1,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 20, top: 10),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        Constant.ASSETS_IMG + 'login_weixin.png',
                        width: 40.0,
                        height: 40.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          '微信',
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff999999)),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        Constant.ASSETS_IMG + 'login_qq.png',
                        width: 40.0,
                        height: 40.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          'QQ',
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff999999)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

class LoginBtn extends StatelessWidget {
  const LoginBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("LoginBtn的build方法");
    var mCount = context.watch<LoginBtnProvider>().inputAccount;
    var mPwd = context.watch<LoginBtnProvider>().inputPwd;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 60.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled))
                return Color(0xffFFD8AF);
              return Color(0xffFF8200);
            },
          ),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          elevation: MaterialStateProperty.all(0),
        ),
        onPressed: (mCount.isEmpty || mPwd.isEmpty)
            ? null
            : () {
                FormData params =
                    FormData.fromMap({'username': mCount, 'password': mPwd});
                DioManager.instance.post(ServiceUrl.login, params, (data) {
                  UserUtil.saveUserInfo(data['data']);
                  ToastUtil.show('登录成功!');
                  Navigator.pop(context);
                  Routes.navigateTo(context, Routes.indexPage);
                }, (error) {
                  ToastUtil.show(error);
                });
              },
        child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: Text(
              "登录",
              style: TextStyle(fontSize: 16.0),
            )),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget();

  @override
  Widget build(BuildContext context) {
    print("title的build方法");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, //子组件的排列方式为主轴两端对齐
      children: <Widget>[
        InkWell(
          child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                Constant.ASSETS_IMG + 'icon_close.png',
                width: 20.0,
                height: 20.0,
              )),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        InkWell(
          child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "帮助",
                style: TextStyle(fontSize: 16.0, color: Color(0xff6B91BB)),
              )),
          onTap: () {},
        ),
      ],
    );
  }
}
