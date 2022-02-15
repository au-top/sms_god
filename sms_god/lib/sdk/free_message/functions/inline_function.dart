typedef InlineResultFunc<T, E> = E Function(T);

E inlineCalc<T, E>(T value, InlineResultFunc<T, E> func) {
  return func(value);
}

T inlineCopyWith<T>(T value, InlineResultFunc<T, T> func) {
  return func(value);
}

typedef NowRunFunc<T> = T Function();

T nowRun<T>(NowRunFunc<T> func) {
  return func();
}
