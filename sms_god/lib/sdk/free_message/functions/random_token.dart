import 'dart:math';

int _tokenNextId = 0;
String randomToken([String? name]) {
  return "${DateTime.now().microsecondsSinceEpoch}_${name ?? Random().nextInt(1 << 8)}_${Random().nextInt(1 << 16)}_${_tokenNextId++}";
}
