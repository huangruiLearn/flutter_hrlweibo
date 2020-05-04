import 'package:flutter/cupertino.dart';

/// 范围样式，规定不同范围不同样式
class RangeStyle extends Comparable<RangeStyle> {
  RangeStyle({@required this.range, this.style});

  /// 范围
  final TextRange range;

  /// 指定样式
  final TextStyle style;

  @override
  int compareTo(RangeStyle other) {
    return range.start.compareTo(other.range.start);
  }

  @override
  String toString() {
    return 'RangeStyle(range:$range, style:$style)';
  }
}
