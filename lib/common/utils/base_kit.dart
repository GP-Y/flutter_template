// 项目中常用的工具类
class BaseKit{
  BaseKit._();

  /// 验证ip地址
  static bool checkIp(String ip) {
    return RegExp(
        r'((25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))')
        .hasMatch(ip);
  }

  /// 检查是否是邮箱格式
  static bool isEmail(String input) {
    String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
    if (input.isEmpty) return false;
    return RegExp(regexEmail).hasMatch(input);
  }

  /// 检查是否是邮箱格式
  static bool isPhone(String input) {
    String regexPhone =
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$';
    if (input.isEmpty) return false;
    return RegExp(regexPhone).hasMatch(input);
  }

  ///检查是否为正确的密码格式
  static bool isPassword(String password) {
    String regPassword = r'^\w{6,20}$';
    if (password.isEmpty) return false;
    return RegExp(regPassword).hasMatch(password);
  }
}
