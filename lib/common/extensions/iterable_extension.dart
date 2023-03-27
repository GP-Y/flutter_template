/// @fileName: iterable_extension
/// @date: 2023/2/9 01:29
/// @author clover
/// @description: 迭代器扩展

extension IterableExtension<E> on Iterable<E> {
  /// 带index的map
  Iterable<T> mapIndex<T>(T Function(E e, int index) toElement) sync* {
    int i = 0;
    for (var element in this) {
      yield toElement(element, i);
      i++;
    }
  }
}
