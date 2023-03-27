import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LazyLoadImageWidget extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final double? radius;

  const LazyLoadImageWidget(this.url,
      {this.height, this.width, this.radius, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        progressIndicatorBuilder: (
          context,
          url,
          downLoadProgress,
        ) {
          return Container(
            width: width,
            height: height,
            color: const Color(0xfff2f2f2),
          );
        },
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: BoxFit.cover,
      ),
    );
  }
}
