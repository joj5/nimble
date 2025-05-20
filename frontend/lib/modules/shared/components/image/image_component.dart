import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageComponent extends StatelessWidget {
  final String url;
  final String placeHolder;
  final double height;
  final double width;
  final BoxFit fit;

  const ImageComponent(
      {super.key,
      required this.url,
      required this.placeHolder,
      required this.height,
      required this.width,
      required this.fit});

  @override
  Widget build(BuildContext context) {
    if (url.startsWith('http')) {
      return CachedNetworkImage(
        placeholder: placeholderWidgetFn(placeHolder) as Widget Function(
            BuildContext, String)?,
        imageUrl: url,
        height: height,
        width: width,
        fit: fit,
        errorWidget: (_, __, ___) {
          return SizedBox(height: height, width: width);
        },
      );
    } else {
      return Image.asset(url, height: height, width: width, fit: fit);
    }
  }

  Widget? Function(BuildContext, String) placeholderWidgetFn(var image) =>
      (_, s) => placeholderWidget(image);

  Widget placeholderWidget(var image) => Image.asset(image, fit: BoxFit.cover);
}
