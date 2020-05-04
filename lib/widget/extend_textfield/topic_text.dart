import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TopicText extends SpecialText {
  static const String flag = '#';
  final int start;

  /// whether show background for @somebody
  final bool showAtBackground;

  TopicText(TextStyle textStyle, SpecialTextGestureTapCallback onTap,
      {this.showAtBackground = false, this.start})
      : super(flag, flag, textStyle, onTap: onTap);

  @override
  InlineSpan finishText() {
    final textStyle =
        this.textStyle?.copyWith(color: Colors.blue, fontSize: 16.0);

    final str = toString();

    String idStr =str.substring(str.indexOf(":")+1,
        str.lastIndexOf("#"));
    String showStr =str.substring(str.indexOf("#"),
        str.lastIndexOf("#")+1).replaceAll(":"+idStr, "");


    return showAtBackground
        ? BackgroundTextSpan(
            background: Paint()..color = Colors.blue.withOpacity(0.15),
            text: showStr,
            actualText: str,
            start: start,

            ///caret can move into special text
            deleteAll: true,
            style: textStyle,
            recognizer: (TapGestureRecognizer()
              ..onTap = () {
                if (onTap != null) onTap(str);
              }))
        : SpecialTextSpan(
            text: showStr,
            actualText: str,
            start: start,
            style: textStyle,
            recognizer: (TapGestureRecognizer()
              ..onTap = () {
                if (onTap != null) onTap(str);
              }));
  }
}

