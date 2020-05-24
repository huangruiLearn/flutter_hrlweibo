import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';

class MessageDynamicPage extends StatefulWidget {
  @override
  _MessageDynamicPageState createState() => _MessageDynamicPageState();
}

class _MessageDynamicPageState extends State<MessageDynamicPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 150),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            Constant.ASSETS_IMG + "msg_no_dynamic.webp",
            width: 120,
            height: 120,
            fit: BoxFit.fill,
          ),
          Text("你暂时还没有动态",
              style: TextStyle(color: Color(0xff333333), fontSize: 14)),
        ],
      ),
    );
  }
}
