import 'dart:ffi';

import 'package:sms_god/sdk/free_message/functions/enum_make.dart';

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
