import 'package:flutter/material.dart';

///
///  create by zmtzawqlp on 2019/5/27
///

class BubblesColor {
  final Color dotPrimaryColor;
  final Color dotSecondaryColor;
  final Color dotThirdColor;
  final Color dotLastColor;

  const BubblesColor({
    @required this.dotPrimaryColor,
    @required this.dotSecondaryColor,
    this.dotThirdColor,
    this.dotLastColor,
  });

  Color get dotThirdColorReal =>
      dotThirdColor == null ? dotPrimaryColor : dotThirdColor;

  Color get dotLastColorReal =>
      dotLastColor == null ? dotSecondaryColor : dotLastColor;
}

class CircleColor {
  final Color start;
  final Color end;
  const CircleColor({
    @required this.start,
    @required this.end,
  });

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final CircleColor typedOther = other;
    return start == typedOther.start && end == typedOther.end;
  }

  @override
  int get hashCode => hashValues(start, end);
}

class OvershootCurve extends Curve {
  const OvershootCurve([this.period = 2.5]);

  final double period;

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    t -= 1.0;
    return t * t * ((period + 1) * t + period) + 1.0;
  }

  @override
  String toString() {
    return '$runtimeType($period)';
  }
}

class LikeCountClip extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Offset.zero & size;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
