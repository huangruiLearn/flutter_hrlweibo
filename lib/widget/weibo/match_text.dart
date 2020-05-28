import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'regex_options.dart';

enum ParsedType { EMAIL, PHONE, URL, CUSTOM }

/// A MatchText class which provides a structure for [ParsedText] to handle
/// Pattern matching and also to provide custom [Function] and custom [TextStyle].
class MatchText {
  /// Used to enforce Predefined regex to match from
  ParsedType type;

  /// If no [type] property is explicitly defined then this propery must be
  /// non null takes a [regex] string
  String pattern;

  /// Takes a custom style of [TextStyle] for the matched text widget
  TextStyle style;

  /// A custom [Function] to handle onTap.
  Function onTap;

  /// A callback function that takes two parameter String & pattern
  ///
  /// @param str - is the word that is being matched
  /// @param pattern - pattern passed to the MatchText class
  ///
  /// eg: Your str is 'Mention [@michel:5455345]' where 5455345 is ID of this user
  /// and @michel the value to display on interface.
  /// Your pattern for ID & username extraction : `/\[(@[^:]+):([^\]]+)\]/`i
  /// Displayed text will be : Mention `@michel`
  Function({String str, String pattern}) renderText;

  /// Creates a MatchText object
  MatchText({
    this.type = ParsedType.CUSTOM,
    this.pattern,
    this.style,
    this.onTap,
    this.renderText,
  });
}
