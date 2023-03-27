import 'package:intl/intl.dart';

/// @fileName: date_extension
/// @date: 2023/2/9 01:29
/// @author clover
/// @description: 日期扩展

/// 日期扩展
extension DateWithNullExtensions on DateTime? {
  ///日期转字符串
  String? get yyyyMMddDash => this == null ? null : DateFormat("yyyy-MM-dd").format(this!);

  ///日期转字符串
  String? get yyyyMMDash => this == null ? null : DateFormat("yyyy-MM").format(this!);

  ///日期转字符串
  String? get yyyyMMddDot => this == null ? null : DateFormat("yyyy.MM.dd").format(this!);

  ///日期转字符串
  String? get yyyyMMDot => this == null ? null : DateFormat("yyyy.MM").format(this!);

  // ignore: non_constant_identifier_names
  String? get MMddChinese => this == null ? null : DateFormat("MM月dd日").format(this!);

  ///时间转字符串
  // ignore: non_constant_identifier_names
  String? get HHmm => this == null ? null : DateFormat("HH:mm").format(this!);

  String? get mm => this == null ? null : DateFormat("mm").format(this!);

  ///时间转字符串
  // ignore: non_constant_identifier_names
  String? get HHmmss => this == null ? null : DateFormat("HH:mm:ss").format(this!);

  String? get yyyyMMddHHmmssDash =>
      this == null ? null : DateFormat("yyyy-MM-dd HH:mm:ss").format(this!);

  String? get yyyyMMddHHmmDash =>
      this == null ? null : DateFormat("yyyy-MM-dd HH:mm").format(this!);

  String? get yyyyMMddHHmmDot =>
      this == null ? null : DateFormat("yyyy.MM.dd HH:mm").format(this!);

  String? get yyyyMMddChinese => this == null ? null : DateFormat("yyyy年MM月dd日").format(this!);
}