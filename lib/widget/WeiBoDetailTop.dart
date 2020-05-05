import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/model/WeiBoModel.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';
 import 'WeiBoItem.dart';

class WeiBoDetailTopWidget extends StatefulWidget {
  final WeiBoModel mModel;
  WeiBoDetailTopWidget({Key key, this.mModel}) : super(key: key);
  @override
  _WeiBoDetailTopWidgetState createState() =>
      _WeiBoDetailTopWidgetState(weiboData: mModel);
}

class _WeiBoDetailTopWidgetState extends State<WeiBoDetailTopWidget> {
  WeiBoModel weiboData;
  _WeiBoDetailTopWidgetState({Key key, this.weiboData});
  @override
  Widget build(BuildContext context) {
    return _wholeItemWidget(context, weiboData);
  }
}

//整个item布局
Widget _wholeItemWidget(BuildContext context, WeiBoModel weiboItem) {
  return Container(
     color: Colors.white,
    child: Column(
      children: <Widget>[

        WeiBoItemWidget(weiboItem,true),

        _shareRow(context, weiboItem),
        new Container(
          margin: EdgeInsets.only(top: 15),
          height: 12,
          color: Color(0xffEFEFEF),
        ), //下划线
      ],
    ),
  );
}


//分享布局
Widget _shareRow(BuildContext context, WeiBoModel weiboItem) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(30.0, 15.0, 0.0, 0.0),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('分享'),
        InkWell(
          onTap: () {},
          child: Container(
               margin: EdgeInsets.only(left: 20),
              child: Image.asset(
                Constant.ASSETS_IMG + 'share_group_wx.png',
                width: 30.0,
                height: 30.0,
              )),
        ),
        InkWell(
          onTap: () {},
          child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Image.asset(
                Constant.ASSETS_IMG + 'share_group_wxfirend.png',
                width: 30.0,
                height: 30.0,
              )),
        ),
        InkWell(
          onTap: () {},
          child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Image.asset(
                Constant.ASSETS_IMG + 'share_group_qq.png',
                width: 30.0,
                height: 30.0,
              )),
        ),
        InkWell(
          onTap: () {},
          child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Image.asset(
                Constant.ASSETS_IMG + 'share_group_qqzone.png',
                width: 30.0,
                height: 30.0,
              )),
        ),
        InkWell(
          onTap: () {},
          child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Image.asset(
                Constant.ASSETS_IMG + 'share_group_long_pic.png',
                width: 30.0,
                height: 30.0,
              )),
        ),
      ],
    ),
  );
}
