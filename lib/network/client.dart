import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:getx_app/common/hive/base_info_box.dart';
import 'package:getx_app/common/utils/utils.dart';
import 'package:getx_app/config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tuple/tuple.dart';

import '../common/debugger/widgets/network_log.dart';
import '../common/queue/initialize_queue.dart';
import 'auth_interceptor.dart';

/// @fileName: client
/// @date: 2023/2/9 01:29
/// @author clover
/// @description: 网络请求封装

class RequestClient with InitializeTask {
  static RequestClient instance = RequestClient._();

  RequestClient._();

  Dio? _dio; //dio实例，网络请求的核心

  String? _baseUrl; //基础url

  late final CacheOptions _cacheOptions;

  /// 拦截器
  final Set<Interceptor> _interceptors = {};

  /// 初始化
  Future<void> init() async {
    _baseUrl = Config.apiUrl;
    _interceptors.add(AuthInterceptor());
    _interceptors.add(LogInterceptor());
    _interceptors.add(NetworkLogInterceptor());
    await _reset(baseUrl: _baseUrl);
  }

  void clearAllRequest() {
    _reset();
  }

  /// 设置代理
  Future<void> setProxy(String ip, int port) async {
    BaseInfoBox.instance.proxyIp = ip;
    BaseInfoBox.instance.proxyPort = port;
    await _reset();
  }

  /// 获取当前代理设置
  Tuple2<String?, int?> getProxy() {
    final ip = BaseInfoBox.instance.proxyIp;
    final port = BaseInfoBox.instance.proxyPort;
    return Tuple2(ip, port);
  }

  ///清除代理设置
  Future<void> clearProxy() async {
    BaseInfoBox.instance.proxyIp = null;
    BaseInfoBox.instance.proxyPort = null;
    await _reset();
  }

  /// 添加拦截器
  void addInterceptor(Interceptor interceptor) {
    _dio?.interceptors.add(interceptor);
    _interceptors.add(interceptor);
  }

  Future<void> _reset({String? baseUrl}) async {
    final String? url = baseUrl ?? _baseUrl;
    if (url == null) {
      throw RequestError(message: "base url is null");
    }
    _dio?.close(force: true);
    _dio = Dio(BaseOptions(
      baseUrl: url,
      receiveTimeout: const Duration(seconds: 30),
    ));
    _dio!.interceptors.clear();
    var dir = await getTemporaryDirectory();
    _cacheOptions = CacheOptions(
      store: HiveCacheStore(dir.path),
      allowPostMethod: true,
    );
    _dio!.interceptors.addAll([
      // CookieManager(CookieJar()),
      ..._interceptors,
      DioCacheInterceptor(options: _cacheOptions),
    ]);
    (_dio!.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (client) {
      var proxyIp = BaseInfoBox.instance.proxyIp;
      var proxyPort = BaseInfoBox.instance.proxyPort;
      client.findProxy = (uri) {
        if (proxyIp != null && proxyPort != null) {
          return "PROXY $proxyIp:$proxyPort";
        }
        return "DIRECT";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<ApiResult?> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    CachePolicy? cachePolicy,
    CachePriority? cachePriority,
    ProgressCallback? onReceiveProgress,
  }) async {
    LogUtil.i(
      'token:${BaseInfoBox.instance.token}\n'
      'path:$path\n'
      'params:$queryParameters\n',
    );
    final response = await _dio!.get(
      path,
      queryParameters: queryParameters,
      options: _buildCachePolicyOptions(options, cachePolicy, cachePriority),
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    return _resolveResponse(response);
  }

  Future<ApiResult?> post(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    CachePolicy? cachePolicy,
    CachePriority? cachePriority,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    LogUtil.i(
      'token:${BaseInfoBox.instance.token}\n'
      'path:$path\n'
      'params:$queryParameters\n'
      'body:$data',
    );
    final response = await _dio!.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: _buildCachePolicyOptions(options, cachePolicy, cachePriority),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return _resolveResponse(response);
  }

  Future<ApiResult?> put(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    CachePolicy? cachePolicy,
    CachePriority? cachePriority,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final response = await _dio!.put<ApiResult?>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: _buildCachePolicyOptions(options, cachePolicy, cachePriority),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return _resolveResponse(response);
  }

  Future<ApiResult?> delete(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    CachePolicy? cachePolicy,
    CachePriority? cachePriority,
  }) async {
    final response = await _dio!.delete<ApiResult?>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: _buildCachePolicyOptions(options, cachePolicy, cachePriority),
      cancelToken: cancelToken,
    );
    return _resolveResponse(response);
  }

  Future<Response<T>> request<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    CachePolicy? cachePolicy,
    CachePriority? cachePriority,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio!.request<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: _buildCachePolicyOptions(options, cachePolicy, cachePriority),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// 将response转换为ApiResult
  ApiResult? _resolveResponse(Response response) {
    if (response.statusCode == HttpStatus.ok) {
      LogUtil.i('请求结果：${response.data}');
      return ApiResult.fromJsonMap(response.data);
    } else {
      throw RequestError(
        httpCode: response.statusCode,
        message: "${response.statusMessage}",
      );
    }
  }

  /// 将缓存策略融合到dio Options中
  Options _buildCachePolicyOptions(
    Options? options,
    CachePolicy? cachePolicy,
    CachePriority? cachePriority,
  ) {
    final customOptions = options ?? Options();
    if (cachePolicy != null) {
      final extra = _cacheOptions
          .copyWith(policy: cachePolicy, priority: cachePriority)
          .toExtra();
      if (customOptions.extra != null) {
        customOptions.extra!.addAll(extra);
      } else {
        customOptions.extra = extra;
      }
    }
    return customOptions;
  }

  @override
  Future<void> onTask() async {
    await init();
  }
}

/// 请求返回值封装
class ApiResult {
  final num? code;
  final String? msg;
  final dynamic data;

  ApiResult({
    this.code,
    this.msg,
    this.data,
  });

  ApiResult.fromJsonMap(Map<String, dynamic> map)
      : code = map["code"],
        msg = map["msg"],
        data = map["data"];

  @override
  String toString() {
    return "ApiResult(code:$code,msg:$msg,data:$data)";
  }
}

/// 错误封装
class RequestError extends Error {
  final int? httpCode;
  final num? serverCode;
  final String message;

  RequestError({
    required this.message,
    this.httpCode,
    this.serverCode,
  });

  @override
  String toString() =>
      "RequestError(httpCode:$httpCode,serverCode:$serverCode,message:$message)";
}
