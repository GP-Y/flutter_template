import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'network_log.dart';
import 'proxy_setting.dart';
import 'system_log.dart';

/// @fileName: floating_button.dart
/// @date: 2023/2/23 15:55
/// @author clover
/// @description: 调试工具入口

class DebugDraggableFloatingButton extends StatefulWidget {
  final double size;

  const DebugDraggableFloatingButton({Key? key, this.size = 52})
      : super(key: key);

  @override
  State<DebugDraggableFloatingButton> createState() =>
      _DebugDraggableFloatingButtonState();
}

class _DebugDraggableFloatingButtonState
    extends State<DebugDraggableFloatingButton> {
  double _x = -100;
  double _y = -100;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        final size = MediaQuery.of(context).size;
        setState(() {
          _x = size.width - widget.size - 20;
          _y = size.height - widget.size - 100;
        });
      }
    });
  }

  bool _show = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final icon = Icon(
      Icons.bug_report,
      color: Colors.white,
      size: widget.size / 2,
    );
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Visibility(
            visible: _show,
            child: Positioned(
              left: _x,
              top: _y,
              child: Draggable(
                onDragEnd: (details) {
                  setState(() {
                    _x = details.offset.dx.clamp(0, size.width - widget.size);
                    _y = details.offset.dy.clamp(0, size.height - widget.size);
                  });
                },
                feedback: _ButtonItem(
                  size: widget.size,
                  child: icon,
                ),
                childWhenDragging: Container(),
                child: _ButtonItem(
                  size: widget.size,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      if (Get.isBottomSheetOpen == true) {
                        Get.back();
                      } else {
                        setState(() {
                          _show = false;
                        });
                        await Get.bottomSheet(const DebugTabContainer());
                        setState(() {
                          _show = true;
                        });
                      }
                    },
                    icon: icon,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ButtonItem extends StatelessWidget {
  final double size;
  final Widget child;
  final Color color;

  const _ButtonItem({
    Key? key,
    required this.size,
    required this.child,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: child,
    );
  }
}

class DebugTabContainer extends StatelessWidget {
  const DebugTabContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: DefaultTabController(
        length: 3,
        child: Column(children: const [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: TabBar(
              tabs: [
                Text("日志查看"),
                Text("网络请求"),
                Text("代理设置"),
              ],
              indicatorColor: Colors.blue,
              labelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.grey,
              padding: EdgeInsets.only(top: 5),
              labelPadding: EdgeInsets.only(bottom: 3),
            ),
          ),
          Expanded(
            child: TabBarView(children: [
              SystemLog(),
              NetworkLog(),
              ProxySetting(),
            ]),
          )
        ]),
      ),
    );
  }
}
