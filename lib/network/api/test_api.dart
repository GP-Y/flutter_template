import 'package:get_template/models/login/login.dart';
import 'package:get_template/network/request.dart';

/// @fileName: test_api
/// @date: 2023/2/9 01:29
/// @author clover
/// @description: api定义

/// api定义
/// 每个定义方法必须写详细注释
abstract class TestApi {
  factory TestApi() = _TestApiImpl;

  /// test
  /// [param1] 参数一
  Future<String?> test(String param1);

  /// 使用账号密码登录
  Future<Login?> login(String phone, String password);
}

/// api实现
class _TestApiImpl with Request implements TestApi {
  /// 接口路径定义
  static const _testUrl = "testUrl";

  /// 账号密码登录api
  static const _loginUrl = '/auth/api/login';

  @override
  Future<String?> test(String parma1) async {
    final ApiResult? result = await simpleGet(
      _testUrl,
      params: {"parma1": parma1},
      // 是否需要缓存
      cache: false,
      // 是否需要loading覆盖
      loading: true,
      // 出现错误是否需要toast弹出错误信息
      toastError: true,
    );

    /// 按需处理code
    if (result?.code == 0) {
      /// 其他返回类型需转换
      /// Model.fromJson(result!.data)
      return result?.data;
    } else {
      return null;
    }
  }

  /// 账号密码登录请求方法
  @override
  Future<Login?> login(String phone, String password) async {
    final ApiResult? result = await simplePost(
      _loginUrl,
      data: {'username': phone, 'password': password},
      cache: false,
      loading: true,
      toastError: true,
    );

    /// 按需处理code
    if (result?.code == 200) {
      return Login.fromJson(result?.data);
    } else {
      return null;
    }
  }
}
