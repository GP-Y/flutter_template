import 'package:flutter/material.dart';
import 'widgets/floating_button.dart';
import 'widgets/network_log.dart';
import 'widgets/system_log.dart';

/// @fileName: debug_kit.dart
/// @date: 2023/2/23 15:55
/// @author clover
/// @description: 调试工具

/// 测试版用于查看请求信息、设置代理、查看日志的工具
class DebugKit {
  DebugKit._();

  /// 是否开启调试模式
  static bool debugModel = true;

  static BuildContext? context;

  static OverlayEntry? _overlayEntry;

  static void setup(BuildContext context) {
    if (DebugKit.context != null) {
      _removeOverlay();
      return;
    }
    DebugKit.context = context;
    if (!context.debugDoingBuild && context.owner?.debugBuilding != true) {
      _insertOverlay(context);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _insertOverlay(context);
      });
    }
  }

  static void _insertOverlay(BuildContext context) {
    final state = Overlay.of(context, rootOverlay: true);
    //初始化日志服务
    SystemLogService.init();
    //初始化网络服务
    NetworkService.init();
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return const DebugDraggableFloatingButton();
      },
    );
    if (_overlayEntry != null) {
      state?.insert(_overlayEntry!);
    }
  }

  static void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      context = null;
    }
  }
}
