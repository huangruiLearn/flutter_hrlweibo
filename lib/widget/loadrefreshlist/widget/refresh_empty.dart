import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/widget/loadrefreshlist/item_notifier.dart';

class RefreshEmpty extends StatelessWidget {
  final ItemNotifier itemNotifier;

  const RefreshEmpty({
    required this.itemNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            child: Center(
              child: Text('没有任何数据'),
            ),
            margin: EdgeInsets.only(top: 350),
          ),
        ),
        onRefresh: () => itemNotifier.onRefresh(true));
  }
}
