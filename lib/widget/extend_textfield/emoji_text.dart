import 'package:extended_text_library/extended_text_library.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EmojiText extends SpecialText {
  static const String flag = '[/';
  final int start;

  /// whether show background for @somebody
  final bool showAtBackground;

  EmojiText(TextStyle textStyle, SpecialTextGestureTapCallback onTap,
      {this.showAtBackground = false, this.start})
      : super(flag, ']', textStyle, onTap: onTap);

  @override
  InlineSpan finishText() {
    final textStyle =
        this.textStyle?.copyWith(color: Colors.blue, fontSize: 16.0);

    final str = toString();
    int mEmojiNew=0;
    try {
       String mEmoji=str.replaceAll(RegExp('(\\[)|(\\/)|(\\])'), "");
       mEmojiNew= int.parse(mEmoji);
     } on Exception catch (_) {
     }


    return showAtBackground
        ? BackgroundTextSpan(
            background: Paint()..color = Colors.blue.withOpacity(0.15),
            text:    String.fromCharCode(mEmojiNew),
            actualText:str,
            start: start,

            ///caret can move into special text
            deleteAll: true,
            style: textStyle,
            recognizer: (TapGestureRecognizer()
              ..onTap = () {
                if (onTap != null) onTap(str);
              }))
        : SpecialTextSpan(
        text:  String.fromCharCode(mEmojiNew),
        actualText:str,
            start: start,
            style: textStyle,
            recognizer: (TapGestureRecognizer()
              ..onTap = () {
                if (onTap != null) onTap(str);
              }));
  }
}

