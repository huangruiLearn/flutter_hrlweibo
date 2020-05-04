/*
 * Author: Jpeng
 * Email: peng8350@gmail.com
 * Time:  2019-07-11 12:23
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

/*
   aim to implements expand all the free empty place when viewport is not full
   ,but this can not correction offset,due to _minScrollExtent,_maxScrollExtent private in RenderViewport
   ,no idea how to do. without doing this,chat list (top when not full && reverse = true) can not be done.
   in my plugin similar issue:#127,# 118
   in flutter similar issue:#12650,#33399,#17444
 */

class ExpandedViewport extends Viewport {
  ExpandedViewport({
    Key key,
    AxisDirection axisDirection = AxisDirection.down,
    AxisDirection crossAxisDirection,
    double anchor = 0.0,
    ScrollPosition offset,
    Key center,
    double cacheExtent,
    List<Widget> slivers = const <Widget>[],
  }) : super(
            key: key,
            slivers: slivers,
            axisDirection: axisDirection,
            crossAxisDirection: crossAxisDirection,
            anchor: anchor,
            offset: offset,
            center: center,
            cacheExtent: cacheExtent);

  @override
  RenderViewport createRenderObject(BuildContext context) {
    // TODO: implement createRenderObject
    return _RenderExpandedViewport(
      axisDirection: axisDirection,
      crossAxisDirection: crossAxisDirection ??
          Viewport.getDefaultCrossAxisDirection(context, axisDirection),
      anchor: anchor,
      offset: offset,
      cacheExtent: cacheExtent,
    );
  }
}

class _RenderExpandedViewport extends RenderViewport {
  _RenderExpandedViewport({
    AxisDirection axisDirection = AxisDirection.down,
    @required AxisDirection crossAxisDirection,
    @required ViewportOffset offset,
    double anchor = 0.0,
    List<RenderSliver> children,
    RenderSliver center,
    double cacheExtent,
  }) : super(
            axisDirection: axisDirection,
            crossAxisDirection: crossAxisDirection,
            offset: offset,
            anchor: anchor,
            children: children,
            center: center,
            cacheExtent: cacheExtent);

  @override
  void performLayout() {
    // TODO: implement performLayout
    super.performLayout();
    RenderSliver expand;
    RenderSliver p = firstChild;
    double totalLayoutExtent = 0;
    double BehindExtent = 0.0, FrontExtent = 0.0;
    while (p != null) {
      totalLayoutExtent += p.geometry.scrollExtent;
      if (p is _RenderExpanded) {
        expand = p;
        FrontExtent = totalLayoutExtent;
      }

      p = childAfter(p);
    }
    double count = 0;
    BehindExtent = totalLayoutExtent - FrontExtent;
    if (expand != null && size.height > totalLayoutExtent) {
      _attemptLayout(expand, size.height, size.width,
          offset.pixels - FrontExtent - (size.height - totalLayoutExtent));
    }
  }

  // _minScrollExtent private in super,no setter method
  double _attemptLayout(RenderSliver expandPosition, double mainAxisExtent,
      double crossAxisExtent, double correctedOffset) {
    assert(!mainAxisExtent.isNaN);
    assert(mainAxisExtent >= 0.0);
    assert(crossAxisExtent.isFinite);
    assert(crossAxisExtent >= 0.0);
    assert(correctedOffset.isFinite);

    // centerOffset is the offset from the leading edge of the RenderViewport
    // to the zero scroll offset (the line between the forward slivers and the
    // reverse slivers).
    final double centerOffset = mainAxisExtent * anchor - correctedOffset;
    final double reverseDirectionRemainingPaintExtent =
        centerOffset.clamp(0.0, mainAxisExtent);

    final double forwardDirectionRemainingPaintExtent =
        (mainAxisExtent - centerOffset).clamp(0.0, mainAxisExtent);
    final double fullCacheExtent = mainAxisExtent + 2 * cacheExtent;
    final double centerCacheOffset = centerOffset + cacheExtent;
    final double reverseDirectionRemainingCacheExtent =
        centerCacheOffset.clamp(0.0, fullCacheExtent);
    final double forwardDirectionRemainingCacheExtent =
        (fullCacheExtent - centerCacheOffset).clamp(0.0, fullCacheExtent);

    final RenderSliver leadingNegativeChild = childBefore(center);
    // positive scroll offsets
    return layoutChildSequence(
      child: expandPosition,
      scrollOffset: math.max(0.0, -centerOffset),
      overlap:
          leadingNegativeChild == null ? math.min(0.0, -centerOffset) : 0.0,
      layoutOffset: centerOffset >= mainAxisExtent
          ? centerOffset
          : reverseDirectionRemainingPaintExtent,
      remainingPaintExtent: forwardDirectionRemainingPaintExtent,
      mainAxisExtent: mainAxisExtent,
      crossAxisExtent: crossAxisExtent,
      growthDirection: GrowthDirection.forward,
      advance: childAfter,
      remainingCacheExtent: forwardDirectionRemainingCacheExtent,
      cacheOrigin: centerOffset.clamp(-cacheExtent, 0.0),
    );
  }
}

//tag
class SliverExpanded extends SingleChildRenderObjectWidget {
  SliverExpanded() : super(child: Container());

  @override
  RenderSliver createRenderObject(BuildContext context) {
    // TODO: implement createRenderObject
    return _RenderExpanded();
  }
}

class _RenderExpanded extends RenderSliver
    with RenderObjectWithChildMixin<RenderBox> {
  @override
  void performLayout() {
    // TODO: implement performLayout
    geometry = SliverGeometry.zero;
  }
}