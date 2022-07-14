import 'dart:ffi';

import 'package:autop_free_dart_utils/enum_make.dart';

enum TimeIndexDir {
  old,
  newed,
}

final timeIndexDirMap = makeEnumMap(
  {
    TimeIndexDir.newed: "1",
    TimeIndexDir.old: "0",
  },
  TimeIndexDir.values,
);
