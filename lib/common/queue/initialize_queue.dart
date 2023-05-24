import 'package:getx_app/common/common.dart';

/// @fileName: initialize_queue
/// @date: 2023/4/20 23:16
/// @author clover
/// @description: 初始化队列,用于初始化一些需要在app启动时执行的任务


class InitializeQueue {
  static final InitializeQueue instance = InitializeQueue._();

  InitializeQueue._();

  /// 记录是队列是否已经执行
  bool _flag = false;

  final List<InitializeTask> _tasks = [];

  /// 添加初始化任务
  void addTask(InitializeTask task) {
    _tasks.add(task);
  }

  /// 执行初始化任务
  Future<void> doTask() async {
    if (_flag) return;
    _flag = true;
    final watcher = Stopwatch()..start();
    // 包含优先级的任务队列
    final highTasks =
        _tasks.where((element) => element.priority != null).toList();
    // 按照优先级排序
    highTasks.sort((a, b) => a.priority! - b.priority!);
    // 普通任务队列
    final normalTasks = _tasks.where((element) => element.priority == null);
    await Future.wait(highTasks.map((e) async {
      try {
        await e.onTask();
      } catch (e) {
        LogUtil.e(e);
      }
    }));
    await Future.wait(normalTasks.map((e) async {
      try {
        return e.onTask();
      } catch (e) {
        LogUtil.e(e);
      }
    }));
    _tasks.clear();
    watcher.stop();
    LogUtil.i("finish initial tasks in ${watcher.elapsedMilliseconds}ms");
  }
}

mixin InitializeTask {
  /// 优先级
  int? priority;

  /// 加载任务
  Future<void> onTask();
}
