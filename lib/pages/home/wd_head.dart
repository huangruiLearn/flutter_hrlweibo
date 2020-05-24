import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';

//微博详情头部标题布局
class WdHeadWidget extends StatefulWidget {
  String mTitle;

  WdHeadWidget(this.mTitle);

  @override
  _WdHeadWidgetState createState() => _WdHeadWidgetState();
}

class _WdHeadWidgetState extends State<WdHeadWidget> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            height: 50,
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Center(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.mTitle,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          child: GestureDetector(
                              onTapDown: _handleTapDown,
                              // Handle the tap events in the order that
                              onTapUp: _handleTapUp,
                              // they occur: down, up, tap, cancel
                              onTap: () {
                                //  Navigator.pop(context);
                              },
                              onTapCancel: _handleTapCancel,
                              child: false
                                  ? Image.asset(
                                      Constant.ASSETS_IMG +
                                          'icon_more_highlighted.png',
                                      width: 23.0,
                                      height: 23.0,
                                    )
                                  : Image.asset(
                                      Constant.ASSETS_IMG + 'icon_more.png',
                                      width: 23.0,
                                      height: 23.0,
                                    )))),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          child: GestureDetector(
                              onTapDown: _handleTapDown,
                              // Handle the tap events in the order that
                              onTapUp: _handleTapUp,
                              // they occur: down, up, tap, cancel
                              onTap: () {
                                Navigator.pop(context);
                              },
                              onTapCancel: _handleTapCancel,
                              child: _highlight
                                  ? Image.asset(
                                      Constant.ASSETS_IMG +
                                          'icon_back_highlighted.png',
                                      width: 23.0,
                                      height: 23.0,
                                    )
                                  : Image.asset(
                                      Constant.ASSETS_IMG + 'icon_back.png',
                                      width: 23.0,
                                      height: 23.0,
                                    )))),
                ],
              ),
            ),
            color: Colors.white),
        Container(
          color: Color(0xffE6E4E3),
          height: 0.5,
        )
      ],
    );
  }
}
