/// @fileName: num_extension
/// @date: 2023/2/9 01:29
/// @author clover
/// @description: 数字扩展

extension IntExtension on int {
  String get hNum {
    if (this < 1000) return "$this";
    if (this < 1000000) return "${(this / 1000).toStringAsFixed(1)}k";
    return "${(this / 1000000).toStringAsFixed(1)}m";
  }
}

extension DoubleExtension on double {
  String get pNum {
    return '¥${(this).toStringAsFixed(2)}';
  }
}
