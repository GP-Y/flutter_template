import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:get_template/common/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tuple/tuple.dart';

/// @fileName: client
/// @date: 2023/2/9 01:29
/// @author clover
/// @description: 网络请求封装

class RequestClient {
  RequestClient._();

  static RequestClient? _client;

  factory RequestClient() {
    _client ??= RequestClient._();
    return _client!;
  }

  final _keyProxyIp = "DIO_PROXY_IP";

  final _keyProxyPort = "DIO_PROXY_PORT";

  Dio? _dio;

  String? baseUrl;

  late final CacheOptions _cacheOptions;

  final Set<Interceptor> _interceptors = {};

  /// 初始化
  Future<void> setupWithInterceptors({
    required String baseUrl,
    required List<Interceptor> interceptors,
  }) async {
    this.baseUrl = baseUrl;
    _interceptors.addAll(interceptors);
    await _reset(baseUrl: baseUrl);
  }

  /// 设置代理
  Future<void> setProxy(String ip, int port) async {
    await StorageUtil().set(_keyProxyIp, ip);
    await StorageUtil().set(_keyProxyPort, port);
    await _reset();
  }

  /// 获取当前代理设置
  Tuple2<String?, int?> getProxy() {
    final ip = StorageUtil().get(_keyProxyIp);
    final port = StorageUtil().get(_keyProxyPort);
    return Tuple2(ip, port);
  }

  ///清除代理设置
  Future<void> clearProxy() async {
    await StorageUtil().remove(_keyProxyIp);
    await StorageUtil().remove(_keyProxyPort);
    await _reset();
  }

  /// 添加拦截器
  void addInterceptor(Interceptor interceptor) {
    _dio?.interceptors.add(interceptor);
    _interceptors.add(interceptor);
  }

  Future<void> _reset({String? baseUrl}) async {
    final String? url = baseUrl ?? this.baseUrl;
    if (url == null) {
      throw RequestError(message: "baseUrl 不能为空！");
    }
    _dio?.close(force: true);
    _dio = Dio(
      BaseOptions(baseUrl: url, receiveTimeout: Duration(seconds: 30)),
    );
    _dio!.interceptors.clear();
    var dir = await getTemporaryDirectory();
    _cacheOptions = CacheOptions(
      store: HiveCacheStore(dir.path),
      allowPostMethod: true,
    );
    _dio!.interceptors.addAll([
      // CookieManager(CookieJar()),
      DioCacheInterceptor(options: _cacheOptions),
      ..._interceptors
    ]);
    (_dio!.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (client) {
      var proxyIp = StorageUtil().get(_keyProxyIp);
      var proxyPort = StorageUtil().get(_keyProxyPort);
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
      'token:token\n'
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
    LogUtil.i(response.data);
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
      'token:token\n'
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
