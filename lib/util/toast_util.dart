import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';


class ToastUtil {
  static show(String msgStr) {
    Fluttertoast.showToast(
        msg: msgStr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Color(0xff4B4B4B),
         textColor: Colors.white,
        fontSize: 13.0
    );
  }
  static showLoad(String msgStr) {
    Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
               Text("登录中，请稍等...")
            ],
          ),
        )
    );
  }

}
