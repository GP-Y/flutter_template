import 'package:flutter/material.dart';
import 'package:getx_app/widgets/lazy_load_image.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("路由没有找到"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        color: const Color(0xFFF1F1F1),
        child: const LazyLoadImageWidget(
            'https://img1.baidu.com/it/u=3753060787,915591864&fm=26&fmt=auto'),
      ),
    );
  }
}
