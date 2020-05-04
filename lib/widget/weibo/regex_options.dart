
/// RegexOptions
class RegexOptions {
  /// Creates a RegexOptions object
  /// If `multiLine` is enabled, then `^` and `$` will match the beginning and
  ///  end of a _line_, in addition to matching beginning and end of input,
  ///  respectively.
  ///
  ///  If `caseSensitive` is disabled, then case is ignored.
  ///
  ///  If `unicode` is enabled, then the pattern is treated as a Unicode
  ///  pattern as described by the ECMAScript standard.
  ///
  ///  If `dotAll` is enabled, then the `.` pattern will match _all_ characters,
  ///  including line terminators.
  const RegexOptions({
    this.multiLine = false,
    this.caseSensitive = true,
    this.unicode = false,
    this.dotAll = false,
  });

  final bool multiLine;
  final bool unicode;
  final bool caseSensitive;
  final bool dotAll;
}
