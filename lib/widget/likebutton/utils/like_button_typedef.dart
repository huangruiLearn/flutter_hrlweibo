import 'package:flutter/material.dart';

///
///  create by zmtzawqlp on 2019/5/27
///

/// tap call back
/// you can send your request here
/// if failed, return null
///
typedef LikeButtonTapCallback = Future<bool> Function(bool isLiked);

///build widget when isLike is changing
typedef LikeWidgetBuilder = Widget Function(bool isLiked);

///build widget when likeCount is changing
typedef LikeCountWidgetBuilder = Widget Function(
    int likeCount, bool isLiked, String text);

enum LikeCountAnimationType {
  //no animation
  none,
  //animation only on change part
  part,
  //animation on all
  all,
}

///like count widget postion
///left of like widget
///right of like widget
enum CountPostion { left, right, top, bottom }

///return count widget with decoration
typedef CountDecoration = Widget Function(Widget count);
