typedef IterableMapper<Input, Output> = Output Function(Input elem);

extension IterableExt<T> on Iterable<T> {
  Iterable<V> safeMap<V>(IterableMapper<T, V> mapper) sync* {
    for (final elem in this) {
      try {
        yield mapper.call(elem);
      } on Object {
        continue;
      }
    }
  }

  T elementAtCircle(int index) {
    int searchedIndex = index % length;
    if (searchedIndex.isNegative) searchedIndex = searchedIndex + length;

    return elementAt(searchedIndex);
  }
}
