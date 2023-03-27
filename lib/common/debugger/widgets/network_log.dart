import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_template/common/utils/utils.dart';

/// @fileName: network_service
/// @date: 2023/2/23 15:55
/// @author clover
/// @description: 网络服务

const String _networkEventStartTime = "NetworkEventStartTime";
const String _networkEventEndTime = "NetworkEventEndTime";

int get _timestamp => DateTime.now().millisecondsSinceEpoch;

/// 网络请求
class NetworkLog extends StatefulWidget {
  const NetworkLog({Key? key}) : super(key: key);

  @override
  State<NetworkLog> createState() => _NetworkLogState();
}

class _NetworkLogState extends State<NetworkLog> {
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _streamSubscription = NetworkLogInterceptor().stream.listen((event) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.builder(
        itemCount: NetworkService.responseList.length,
        itemBuilder: (context, index) {
          final response = NetworkService.responseList[index];
          return _ResponseCard(
            key: ValueKey<int>(response.startTimeMilliseconds),
            response: response,
          );
        },
      ),
      Positioned(
        bottom: 10,
        right: 20,
        child: FloatingActionButton(
          onPressed: () {
            NetworkService.cleanResponse();
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
    super.dispose();
    _streamSubscription?.cancel();
    _streamSubscription = null;
  }
}

class NetworkService {
  NetworkService._() {
    _networkLogInterceptor.stream.listen((event) {
      responseList.add(event);
      if (responseList.length > 50) responseList.removeAt(0);
    });
  }

  static void init() {
    LogKit.i('NetworkServices init');
    if (_instance == null) {
      _instance = NetworkService._();
    }
  }

  static NetworkService? _instance;

  static NetworkLogInterceptor _networkLogInterceptor = NetworkLogInterceptor();

  static List<Response> responseList = [];

  static void cleanResponse() => responseList.clear();
}

class NetworkLogInterceptor extends Interceptor {
  NetworkLogInterceptor._();

  static NetworkLogInterceptor? _interceptor;

  factory NetworkLogInterceptor() => _interceptor ??= NetworkLogInterceptor._();

  final _streamController = StreamController<Response>.broadcast();

  Stream<Response> get stream => _streamController.stream;

  void removeStream() {
    _streamController.close();
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[_networkEventStartTime] = _timestamp;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    response.requestOptions.extra[_networkEventEndTime] = _timestamp;
    _streamController.add(response);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // err.response ??= Response<dynamic>(requestOptions: err.requestOptions);
    err.response!.requestOptions.extra[_networkEventEndTime] = _timestamp;
    _streamController.add(err.response!);
    super.onError(err, handler);
  }
}

class _ResponseCard extends StatefulWidget {
  const _ResponseCard({
    required Key? key,
    required this.response,
  }) : super(key: key);

  final Response<dynamic> response;

  @override
  _ResponseCardState createState() => _ResponseCardState();
}

class _ResponseCardState extends State<_ResponseCard> {
  final ValueNotifier<bool> _isExpanded = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isExpanded.dispose();
    super.dispose();
  }

  void _switchExpand() {
    _isExpanded.value = !_isExpanded.value;
  }

  Response<dynamic> get _response => widget.response;

  RequestOptions get _request => _response.requestOptions;

  /// The start time for the [_request].
  DateTime get _startTime => _response.startTime;

  /// The end time for the [_response].
  DateTime get _endTime => _response.endTime;

  /// The duration between the request and the response.
  Duration get _duration => _endTime.difference(_startTime);

  /// Status code for the [_response].
  int get _statusCode => _response.statusCode ?? 0;

  /// Colors matching status.
  Color get _statusColor {
    if (_statusCode >= 200 && _statusCode < 300) {
      return Colors.lightGreen;
    }
    if (_statusCode >= 300 && _statusCode < 400) {
      return Colors.orangeAccent;
    }
    if (_statusCode >= 400 && _statusCode < 500) {
      return Colors.purple;
    }
    if (_statusCode >= 500 && _statusCode < 600) {
      return Colors.red;
    }
    return Colors.blueAccent;
  }

  /// The method that the [_request] used.
  String get _method => _request.method;

  /// The [Uri] that the [_request] requested.
  Uri get _requestUri => _request.uri;

  /// Data for the [_request].
  String? get _requestDataBuilder {
    if (_request.data is Map) {
      return _encoder.convert(_request.data);
    }
    return _request.data?.toString();
  }

  /// Data for the [_response].
  String get _responseDataBuilder {
    if (_response.data is Map) {
      return _encoder.convert(_response.data);
    }
    return _response.data.toString();
  }

  Widget _detailButton(BuildContext context) {
    return TextButton(
      onPressed: _switchExpand,
      style: _buttonStyle(context),
      child: const Text(
        '详情🔍',
        style: TextStyle(fontSize: 12, height: 1.2),
      ),
    );
  }

  Widget _infoContent(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(_startTime.hms()),
        const SizedBox(width: 6),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 1,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: _statusColor,
          ),
          child: Text(
            _statusCode.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          _method,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 6),
        Text('${_duration.inMilliseconds}ms'),
        const Spacer(),
        _detailButton(context),
      ],
    );
  }

  Widget _detailedContent(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isExpanded,
      builder: (_, bool value, __) {
        if (!value) {
          return const SizedBox.shrink();
        }
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (_requestDataBuilder != null)
                _TagText(tag: 'Request data', content: _requestDataBuilder!),
              _TagText(tag: 'Response body', content: _responseDataBuilder),
              _TagText(
                tag: 'Response headers',
                content: '\n${_response.headers}',
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: Colors.white,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _infoContent(context),
            const SizedBox(height: 10),
            _TagText(tag: 'Uri', content: '$_requestUri'),
            _detailedContent(context),
          ],
        ),
      ),
    );
  }
}

const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

ButtonStyle _buttonStyle(
  BuildContext context, {
  EdgeInsetsGeometry? padding,
}) {
  return TextButton.styleFrom(
    padding: padding ?? const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
    minimumSize: Size.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(999999),
    ),
    backgroundColor: Colors.blue,
    primary: Colors.white,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}

class _TagText extends StatelessWidget {
  const _TagText({
    Key? key,
    required this.tag,
    required this.content,
    this.selectable = true,
  }) : super(key: key);

  final String tag;
  final String content;
  final bool selectable;

  TextSpan get span {
    return TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: '$tag: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: content.notBreak),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget text;
    if (selectable) {
      text = SelectableText.rich(span);
    } else {
      text = Text.rich(span);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: text,
    );
  }
}

extension _StringExtension on String {
  String get notBreak => Characters(this).toList().join('\u{200B}');
}

extension _DateTimeExtension on DateTime {
  String hms([String separator = ':']) => '$hour$separator'
      '${'$minute'.padLeft(2, '0')}$separator'
      '${'$second'.padLeft(2, '0')}';
}

extension ResponseExtension on Response<dynamic> {
  int get startTimeMilliseconds =>
      requestOptions.extra[_networkEventStartTime] as int;

  int get endTimeMilliseconds =>
      requestOptions.extra[_networkEventEndTime] as int;

  DateTime get startTime =>
      DateTime.fromMillisecondsSinceEpoch(startTimeMilliseconds);

  DateTime get endTime =>
      DateTime.fromMillisecondsSinceEpoch(endTimeMilliseconds);
}
