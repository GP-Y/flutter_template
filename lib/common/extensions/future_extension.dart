import 'package:get_template/common/common.dart';

/// @fileName: future_extension
/// @date: 2023/4/22 16:51
/// @author clover
/// @description: Future扩展

extension FutureExtension<T> on Future<T> {
  /// 为future添加loading遮罩
  Future<T> get loading async {
    try {
      BaseUtil.showLoading();
      final result = await this;
      BaseUtil.closeLoading();
      return result;
    } catch (e) {
      BaseUtil.closeLoading();
      rethrow;
    }
  }
}
