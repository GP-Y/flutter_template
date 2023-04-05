import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_template/common/utils/utils.dart';

/// @fileName: log_service
/// @date: 2023/2/9 11:04
/// @author clover
/// @description: 日志服务

class SystemLog extends StatefulWidget {
  const SystemLog({Key? key}) : super(key: key);

  @override
  State<SystemLog> createState() => _SystemLogState();
}

class _SystemLogState extends State<SystemLog> {
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _streamSubscription = LogUtil.addLogListener((event, stream) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.builder(
        reverse: true,
        itemCount: SystemLogService.logList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            color: Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${SystemLogService.logList[index].tag}',
                    style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '${SystemLogService.logList[index].time}',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  Text(
                    '${SystemLogService.logList[index].message}',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      Positioned(
        bottom: 10,
        right: 20,
        child: FloatingActionButton(
          onPressed: () {
            SystemLogService.cleanLogs();
            setState(() {});
          },
          mini: true,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
      )
    ]);
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
    super.dispose();
  }
}

class SystemLogService {
  SystemLogService._() {
    LogUtil.addLogListener((event, stream) {
      logList.add(event);
      if (logList.length > 100) logList.removeAt(0);
    });
  }

  static void init() {
    LogUtil.i('SystemLogService init');
    if (_instance == null) {
      _instance = SystemLogService._();
    }
  }

  static List<LogEvent> logList = [];

  static SystemLogService? _instance;

  static void cleanLogs() => logList.clear();
}
