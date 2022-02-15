extension MapExtStringDynamic on Map {
  void removeNullAttr() {
    removeWhere((key, value) => value == null);
  }
}

extension MapExtDynamicDynamic<K, V> on Map<K, V> {
  T? getValue<T extends V>(K key) {
    return this[key] as T;
  }
}
