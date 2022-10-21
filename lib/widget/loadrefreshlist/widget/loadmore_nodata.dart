import 'package:flutter/material.dart';

class LoadMoreNoData extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              "没有更多数据",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            )));
  }
}
