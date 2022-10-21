import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/widget/loadrefreshlist/item_notifier.dart';

class LoadMoreError extends StatelessWidget {
  final ItemNotifier itemNotifier;
  final bool doLoadMore;

  const LoadMoreError({
     required this.itemNotifier,
     required this.doLoadMore,

  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.refresh,
                      color: Colors.grey,
                    ),
                    Text("加载失败,点击重试..."),
                  ],
                )),
          )),
    onTap: () {
     this.itemNotifier.loadmoreRetry(doLoadMore);
    }
    );
  }
}
