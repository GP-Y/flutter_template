import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  final Function() onPressed;

  const BackButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.arrow_back_ios, size: 30),
    );
  }
}
