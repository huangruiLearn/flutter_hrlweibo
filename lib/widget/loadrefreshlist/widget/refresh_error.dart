import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/constant/constant.dart';
import 'package:flutter_hrlweibo/widget/loadrefreshlist/item_notifier.dart';

class RefreshError extends StatelessWidget {
  final ItemNotifier itemNotifier;

  const RefreshError({
    required this.itemNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: InkWell(
      onTap: itemNotifier.refreshRetry,
      child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 100),
                child: Image.asset(
                  Constant.ASSETS_IMG + 'load_error.png',
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(right: 5, top: 20),
                  child: Text(
                    "加载失败,点击重试",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ))
            ],
          )),
    ),);
  }
}
