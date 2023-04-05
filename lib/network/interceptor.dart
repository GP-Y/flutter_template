import 'package:dio/dio.dart';
import 'package:get_template/common/utils/utils.dart';
import 'token_util.dart';

/// @fileName: interceptor
/// @date: 2023/2/9 01:29
/// @author clover
/// @description: 拦截器配置

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = TokenUtil().getToken();
    options.headers.putIfAbsent("Authorization", () => "$token");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //todo 处理token过期，被踢出等特殊事件
    LogUtil.i('onResponse');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    LogUtil.i(err.message);
    super.onError(err, handler);
  }
}
