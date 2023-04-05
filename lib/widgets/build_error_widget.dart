import 'package:flutter/material.dart';
import 'package:get_template/common/utils/utils.dart';

class BuildErrorWidget extends StatelessWidget {
  const BuildErrorWidget._(this.details, {Key? key}) : super(key: key);

  final FlutterErrorDetails details;

  static void takeOver() {
    ErrorWidget.builder = (FlutterErrorDetails d) {
      LogUtil.e('Error has been delivered to the ErrorWidget: ${d.exception}');
      return BuildErrorWidget._(d);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Color.lerp(
            Theme.of(context).canvasColor,
            const Color(0xff007fff),
            0.1,
          ),
        ),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            color: Theme.of(context).textTheme.caption?.color,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const FractionallySizedBox(
                widthFactor: 0.25,
                child: FlutterLogo(),
              ),
              const SizedBox(height: 20),
              const Text(
                '构建时遇到错误',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                details.exception.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                details.stack.toString(),
                style: const TextStyle(fontSize: 13),
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
