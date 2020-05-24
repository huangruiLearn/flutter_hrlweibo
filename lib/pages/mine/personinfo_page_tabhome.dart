import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/util/date_util.dart';

class PersonInfoHomeHome extends StatefulWidget {
  String name;
  String desc;
  int registtime;
  String gender;

  PersonInfoHomeHome(this.name, this.desc, this.registtime, this.gender);

  @override
  _PersonInfoHomeHomeState createState() => _PersonInfoHomeHomeState();
}

class _PersonInfoHomeHomeState extends State<PersonInfoHomeHome> {
  Widget mCommonInfo(String title, String content) {
    return Container(
      child: Column(
        children: <Widget>[
          new Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
            ),
            child: new IntrinsicHeight(
              child: new Row(
                children: <Widget>[
                  new Container(
                    width: 80,
                    margin: const EdgeInsets.only(left: 15.0),
                    child: Text(title,
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                  ),
                  new Container(
                    child: Text(content,
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              Container(
                height: 0.5,
                color: Colors.white,
              ),
              Container(
                height: 0.5,
                color: Colors.black12,
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xffEFEEEC),
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
            ),
            Container(
              color: Colors.white,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 12.0, bottom: 12, left: 15),
              child: Text(
                '基本资料',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                  height: 0.5,
                  color: Colors.white,
                ),
                Container(
                  height: 0.5,
                  color: Colors.black12,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                ),
              ],
            ),
            mCommonInfo("昵称", widget.name),
            mCommonInfo("简介", widget.desc),
            mCommonInfo(
                "注册时间",
                DateUtil.getFormatTime3(
                    DateTime.fromMillisecondsSinceEpoch(widget.registtime))),
            mCommonInfo("性别", widget.gender == "1" ? "男" : "女"),
            mCommonInfo("阳光信用", "120"),
            Container(
              color: Colors.white,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.only(top: 12.0, bottom: 12, left: 15),
              child: Text(
                '查看全部微博',
                style: TextStyle(color: Color(0xff666666), fontSize: 14),
              ),
            ),
          ],
        ));
  }
}
