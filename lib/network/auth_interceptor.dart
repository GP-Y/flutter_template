import 'package:dio/dio.dart';
import 'package:getx_app/common/hive/base_info_box.dart';
import 'package:getx_app/common/utils/utils.dart';

/// @fileName: interceptor
/// @date: 2023/2/9 01:29
/// @author clover
/// @description: 拦截器配置

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = BaseInfoBox.instance.token;
    options.headers.putIfAbsent("x-platform-version", () => "app-2.0.0");
    if (token != null) {
      options.headers.putIfAbsent("Authorization", () => "Bearer $token");
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    ///todo 处理token过期，被踢出等特殊事件
    LogUtil.i(response.data);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    LogUtil.i(err.message);
    super.onError(err, handler);
  }
}
