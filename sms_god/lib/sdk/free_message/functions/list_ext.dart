import 'dart:math';

extension ListExt<E> on List<E> {
  /// 分组
  /// [1,2,3,4,5,6,7,8]
  ///   || (count is 3)
  ///   V
  /// [[1,2,3],[4,5,6],[7,8]]
  List<List<E>> group(int count) {
    final List<List<E>> returnList = [];
    final List<E> cumulative = [];
    for (int i = 0; i < length; i++) {
      cumulative.add(this[i]);
      if (cumulative.length == count) {
        returnList.add(List.from(cumulative));
        cumulative.clear();
      }
    }
    if (cumulative.isNotEmpty) {
      returnList.add(cumulative);
    }
    return returnList;
  }

  /// 类似于 String Join
  /// F() = builder()
  /// [A,B,C,D,E]
  ///    ||
  ///    V
  /// [A,F(1),B,F(2),C,F(3),D,F(4),E]
  List<E> separate(E Function(int index) builder) {
    final separateLength = length - 1;
    final List<E> result = [];
    if (separateLength > 0) {
      for (int i = 0; i < separateLength; i++) {
        result.add(this[i]);
        result.add(builder(i));
      }
      result.add(last);
      return result;
    } else {
      return List<E>.from(this);
    }
  }

  /// 生长
  /// [A]=>[A,builder(A)]=>[A,A1]
  /// [A,B,C,D,E,F]
  ///  \\
  ///   V
  /// [A,A1,B,B1,C,C1,D,D1,E,E1,F,F1]
  List<E> grow(E Function(int) builder) {
    final List<E> returnList = [];
    for (int i = 0; i < length; i++) {
      returnList.add(this[i]);
      returnList.add(builder(i));
    }
    return returnList;
  }

  E? get(int index) {
    if (index < 0 && length + index > 0) {
      return this[length + index];
    } else if (index < length) {
      return this[index];
    }
    return null;
  }

  /// 去重
  List<E> unRepeat(String Function(E v) toKey) {
    final hashmap = <String, E>{};
    forEach((element) {
      hashmap[toKey(element)] = element;
    });
    return hashmap.values.toList();
  }

  /// 随机读取一个元素
  E? randomGet() {
    if (isNotEmpty) {
      return this[Random().nextInt(length)];
    } else {
      return null;
    }
  }

  /// 删除所有空 [null] 元素
  /// 并且返回 this 而不是新数组
  List<E> removeAllNull() {
    while (remove(null)) {}
    return this;
  }
}
