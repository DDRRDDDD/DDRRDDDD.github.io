typedef Transformer<T, R> = R Function(T value);
typedef OrElse<R> = R? Function();

extension Let<T> on T {
  R let<R>(Transformer<T, R> transform) {
    return transform(this);
  }
}

extension MapLookup<K, V> on Map<K, V> {
  V? lookup(K key) {
    return this[key];
  }
}