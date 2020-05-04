import 'package:flutter/material.dart';
import 'package:flutter_hrlweibo/widget/likebutton/utils/like_button_model.dart';
import 'package:flutter_hrlweibo/widget/likebutton/utils/like_button_util.dart';

///
///  create by zmtzawqlp on 2019/5/27
///

class CirclePainter extends CustomPainter {
  Paint circlePaint = new Paint();
  //Paint maskPaint = new Paint();

  final double outerCircleRadiusProgress;
  final double innerCircleRadiusProgress;
  final CircleColor circleColor;

  CirclePainter(
      {@required this.outerCircleRadiusProgress,
      @required this.innerCircleRadiusProgress,
      this.circleColor = const CircleColor(
          start: const Color(0xFFFF5722), end: const Color(0xFFFFC107))}) {
    //circlePaint..style = PaintingStyle.fill;
    circlePaint..style = PaintingStyle.stroke;
    //maskPaint..blendMode = BlendMode.clear;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double center = size.width * 0.5;
    _updateCircleColor();
    // canvas.saveLayer(Offset.zero & size, Paint());
    // canvas.drawCircle(Offset(center, center),
    //     outerCircleRadiusProgress * center, circlePaint);
    // canvas.drawCircle(Offset(center, center),
    //     innerCircleRadiusProgress * center + 1, maskPaint);
    // canvas.restore();
    //flutter web don't support BlendMode.clear.
    final strokeWidth = outerCircleRadiusProgress * center -
        (innerCircleRadiusProgress * center);
    if (strokeWidth > 0.0) {
      circlePaint..strokeWidth = strokeWidth;
      canvas.drawCircle(Offset(center, center),
          outerCircleRadiusProgress * center, circlePaint);
    }
  }

  void _updateCircleColor() {
    double colorProgress = clamp(outerCircleRadiusProgress, 0.5, 1.0);
    colorProgress = mapValueFromRangeToRange(colorProgress, 0.5, 1.0, 0.0, 1.0);
    circlePaint
      ..color = Color.lerp(circleColor.start, circleColor.end, colorProgress);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (oldDelegate.runtimeType != this.runtimeType) return true;
    final CirclePainter old = oldDelegate;

    return old.outerCircleRadiusProgress != old.outerCircleRadiusProgress ||
        old.innerCircleRadiusProgress != old.innerCircleRadiusProgress ||
        old.circleColor != old.circleColor;
  }
}
