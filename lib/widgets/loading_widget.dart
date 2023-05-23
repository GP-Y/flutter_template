import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @fileName: loading_widget
/// @date: 2023/5/23 15:31
/// @author clover
/// @description: loading组件

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, 0.6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const CupertinoActivityIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
