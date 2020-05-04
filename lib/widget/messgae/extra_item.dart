import 'package:flutter/material.dart';

//https://www.jianshu.com/p/821ab43b5ebe
class ExtraItemContainer extends StatefulWidget {
  ExtraItemContainer(
      {Key key,
      this.text,
      this.leadingIconPath,
      this.leadingHighLightIconPath,
      @required this.onTab})
      : super(key: key);

  final Function onTab;
  final String text;

  final String leadingIconPath;
  final String leadingHighLightIconPath;

  _ExtraItemContainerState createState() => _ExtraItemContainerState();
}

class _ExtraItemContainerState extends State<ExtraItemContainer> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    print("_handleTapDown");
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    print("_handleTapUp");

    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    print("_handleTapCancel");

    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    print("_handleTap");

    widget.onTab();
  }

  Widget build(BuildContext context) {
    return Container(
       child:Column(
        children: <Widget>[
          GestureDetector(

            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTap: _handleTap,
            onTapCancel: _handleTapCancel,
            child: Container(
              child:
              _highlight
                  ? Image.asset(widget.leadingHighLightIconPath,width: 55,height: 55,)
                  : Image.asset(widget.leadingIconPath,width: 55,height: 55,),
              // Padding(padding: EdgeInsets.only(left: 15)),
            ),
          ),
          Text(widget.text,
              style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black)),
        ],
      ) ,
    );
  }
}
