/// 编译出来的
/// Enum 对象
class EnumMap<K, V> {
  late Map<dynamic, dynamic> rawEnumMap;
  EnumMap(this.rawEnumMap);

  V? toValue(K k) {
    return rawEnumMap[k];
  }

  K? toEnum(V v) {
    return rawEnumMap[v];
  }

  dynamic operator [](dynamic getK) {
    return rawEnumMap[getK];
  }
}

/// 模板 [K] 为 enum
/// [V] 为 value ( 非 enum 值
/// 将 dart的 enum 编译为 类似 typescript 的enum
/// [verification] 用于检测编译出来的 Enum Map是否完全映射了 [K] 对应的Enum
/// [verification] 传入 enum 的 values 如果不需要检查则传入 null
EnumMap<K, V> makeEnumMap<K, V>(Map<K, V> enumConfig, List<K>? verification) {
  /// 检测Keys的完整
  assert(verification == null || verification.length == enumConfig.keys.length);
  final resultConfig = <dynamic, dynamic>{};
  enumConfig.forEach((key, value) {
    resultConfig[key] = value;
    resultConfig[value] = key;
  });

  /// 映射有无重叠
  assert(resultConfig.keys.length == enumConfig.keys.length * 2);
  return EnumMap<K, V>(resultConfig);
}
