import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';
import 'package:flutter_hrlweibo/routers/routers.dart';
import 'package:flutter_hrlweibo/util/sp_util.dart';
import 'package:flutter_hrlweibo/util/user_util.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    Future.delayed(new Duration(seconds: 1), () {

      if (!UserUtil.isLogin()) {
        Navigator.pop(context);
        Routes.navigateTo(context, Routes.loginPage, clearStack: true);
      } else {
        Navigator.pop(context);
        Routes.navigateTo(context, Routes.indexPage, clearStack: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: new Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 100),
                    child: Image.asset(
                      Constant.ASSETS_IMG + 'welcome_android_slogan.png',
                      width: 200.0,
                      height: 100.0,
                    ),
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      Constant.ASSETS_IMG + 'welcome_android_logo.png',
                      width: 100.0,
                      height: 100.0,
                    ),
                    color: Color(0xFFFFFFFF),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
