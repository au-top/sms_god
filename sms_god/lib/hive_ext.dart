import 'package:hive/hive.dart';

extension HiveSyncBox on HiveInterface {
  Future syncBox(String boxName) async {
    await Hive.box(boxName).close();
    await Hive.openBox(boxName);
  }
}
