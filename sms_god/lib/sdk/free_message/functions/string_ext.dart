import 'package:flutter/cupertino.dart';

extension StringExt on String {
  String? get(int index) {
    if (index < 0 && length + index > 0) {
      return this[length + index];
    } else if (index < length) {
      return this[index];
    }
    return null;
  }

  /// 空白不可见字符
  static String emptyChar = '\u{200B}';

  /// 使用空白字符 [emptyChar] 插入在每个字之间让换行以 字 为单位
  String get toCharacterWrap => Characters(this).join(emptyChar);
}
