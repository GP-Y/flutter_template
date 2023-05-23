import 'date_extension.dart';
import 'package:intl/intl.dart';

/// @fileName: string_extension
/// @date: 2023/2/9 01:29
/// @author clover
/// @description: 字符串扩展

extension StringExtension on String? {
  DateTime? get datetime {
    if (this == null) return null;
    String pattern = r"^(\d{4})[\.\-\/](\d{1,2})[\.\-\/](\d{1,2}).(\d{1,2}):(\d{1,2}):(\d{1,2})$";
    var reg = RegExp(pattern);
    if (reg.hasMatch(this!)) {
      try {
        var list = reg.allMatches(this!).first.groups([1, 2, 3, 4, 5, 6]);
        return DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse("${list[0]}-${list[1]}-${list[2]} ${list[3]}:${list[4]}:${list[5]}");
      } catch (e) {
        return null;
      }
    }
    try {
      return DateFormat("yyyy-MM-dd HH:mm:ss").parse(this!);
    } catch (e) {
      return null;
    }
  }

  DateTime? get date {
    if (this == null) return null;
    String pattern = r"^(\d{4})[\.\-\/](\d{1,2})[\.\-\/](\d{1,2})$";
    var reg = RegExp(pattern);
    if (reg.hasMatch(this!)) {
      try {
        var list = reg.allMatches(this!).first.groups([1, 2, 3]);
        return DateFormat("yyyy-MM-dd").parse("${list[0]}-${list[1]}-${list[2]}");
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// 1.2分钟之内展示刚刚
  /// 2.2-60分钟内展示xx分钟前
  /// 3.1小时之前展示：11:23
  /// 4.跨天展示02-02
  /// 5.跨年展示2022-03-22
  String get humanTime {
    final date = datetime;
    if (date == null) return "";
    final current = DateTime.now();
    final duration = current.difference(date);
    if (duration.inMinutes <= 2) return "刚刚";
    if (duration.inMinutes < 60) return "${duration.inMinutes}分钟前";
    if (date.isAfter(DateTime(current.year, current.month, current.day))) {
      return "${"${date.hour}".padLeft(2, "0")}:${"${date.minute}".padLeft(2, "0")}";
    }
    final month = "${date.month}".padLeft(2, "0");
    final day = "${date.day}".padLeft(2, "0");
    if (date.year == current.year) return "$month-$day";
    return "${date.year}-$month-$day";
  }

  /// hour:minute
  Duration? get hmDuration {
    if (this == null) return null;
    String pattern = r"^(\d{1,2}):(\d{1,2})$";
    var reg = RegExp(pattern);
    if (reg.hasMatch(this!)) {
      final hm = this!.split(":");
      return Duration(hours: int.parse(hm[0]), minutes: int.parse(hm[1]));
    }
    return null;
  }

  String? get cardBirthToDateString {
    if (this == null) return null;
    try {
      final year = this!.substring(0, 4);
      final month = this!.substring(4, 6);
      final day = this!.substring(6, 8);
      return DateTime(int.parse(year), int.parse(month), int.parse(day)).yyyyMMddDash;
    } catch (e) {
      return null;
    }
  }
}
