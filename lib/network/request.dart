import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_template/network/client.dart';
import 'package:get/get.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
export 'client.dart';

/// @fileName: request
/// @date: 2023/2/9 01:29
/// @author clover
/// @description: api功能聚合

typedef RequestHandler = Future<ApiResult?> Function(CancelToken? cancelToken);

mixin Request {
  RequestClient get client => RequestClient.instance;

  /// [cache] 是否需要缓存
  /// [loading] 是否需要loading覆盖
  /// [toastError] 出现错误是否需要toast弹出错误信息
  Future<ApiResult?> simpleGet(
    String path, {
    Map<String, dynamic>? params,
    bool cache = false,
    bool loading = false,
    bool toastError = true,
  }) async {
    return wrapper(
      (cancelToken) async {
        return await client.get(
          path,
          queryParameters: params,
          cachePolicy: cache ? CachePolicy.forceCache : null,
          cancelToken: cancelToken,
        );
      },
      loading: loading,
      toastError: toastError,
    );
  }

  /// [cache] 是否需要缓存
  /// [loading] 是否需要loading覆盖
  /// [toastError] 出现错误是否需要toast弹出错误信息
  Future<ApiResult?> simplePost(
    String path, {
    dynamic data,
    Map<String, dynamic>? params,
    bool cache = false,
    bool loading = false,
    bool toastError = true,
  }) async {
    return wrapper((cancelToken) async {
      return await client.post(
        path,
        data: data,
        queryParameters: params,
        cachePolicy: cache ? CachePolicy.forceCache : null,
        cancelToken: cancelToken,
      );
    }, loading: loading, toastError: toastError);
  }

  /// [loading] 是否需要loading覆盖
  /// [toastError] 出现错误是否需要toast弹出错误信息
  Future<ApiResult?> simplePut(
    String path, {
    dynamic data,
    Map<String, dynamic>? params,
    bool loading = false,
    bool toastError = true,
  }) async {
    return wrapper((cancelToken) async {
      return await client.put(
        path,
        data: data,
        queryParameters: params,
        cancelToken: cancelToken,
      );
    }, loading: loading, toastError: toastError);
  }

  /// [loading] 是否需要loading覆盖
  /// [toastError] 出现错误是否需要toast弹出错误信息
  Future<ApiResult?> simpleDelete(
    String path, {
    dynamic data,
    Map<String, dynamic>? params,
    bool loading = false,
    bool toastError = true,
  }) async {
    return wrapper((cancelToken) async {
      return await client.delete(
        path,
        data: data,
        queryParameters: params,
        cancelToken: cancelToken,
      );
    }, loading: loading, toastError: toastError);
  }

  /// [handler] 实际请求
  /// [loading] 是否需要loading覆盖
  /// [toastError] 出现错误是否需要toast弹出错误信息
  Future<ApiResult?> wrapper(
    RequestHandler handler, {
    bool loading = false,
    bool toastError = true,
    bool handleResult = true,
  }) async {
    try {
      CancelToken? cancelToken;
      if (loading) {
        cancelToken = CancelToken();
        showLoading(cancelToken);
      }
      final result = await handler(cancelToken);
      if (loading) {
        closeLoading();
      }
      if (result != null && handleResult) {
        return await _handleResult(result, toastError);
      } else {
        return result;
      }
    } catch (e) {
      if (loading) closeLoading();
      if (toastError) toastErrorMessage(e);
    }
    return null;
  }

  /// 显示loading
  void showLoading(CancelToken cancelToken) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          /// 拦截到返回键
          /// dialog被手动关闭，此时需要取消请求
          cancelToken.cancel("用户手动取消");
          return Future.value(true);
        },
        child: Center(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 0, 0, 0.6),
              borderRadius: BorderRadius.circular(10.0),
            ),
            width: 80,
            height: 80,
            child: const CupertinoActivityIndicator(),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// 取消loading
  void closeLoading() {
    if (Get.isDialogOpen == true) {
      Get.close(1);
    }
  }

  /// 处理请求结果
  Future<ApiResult?> _handleResult(ApiResult result, bool toastError) async {
    return result;
  }

  /// 请求出错弹窗
  void toastErrorMessage(dynamic e) {
    if (e is DioError) {
      Get.snackbar("请求错误", e.message ?? '');
    } else if (e is RequestError) {
      Get.snackbar("请求错误", e.message);
    } else {
      Get.snackbar("请求错误", "$e");
    }
  }
}
