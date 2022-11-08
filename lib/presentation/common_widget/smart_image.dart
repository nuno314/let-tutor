import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'cache_network_image_wrapper.dart';

class SmartImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;

  const SmartImage({
    Key? key,
    required this.image,
    this.width,
    this.height,
    this.fit,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image.contains('http')) {
      return CachedNetworkImageWrapper.item(
        url: image,
        width: width,
        height: height,
        fit: fit,
      );
    }
    if (image.contains('svg')) {
      return SvgPicture.asset(
        image,
        width: width,
        height: height,
        color: color,
      );
    }

    return Image.asset(
      image,
      width: width,
      height: height,
      fit: fit,
      color: color,
    );
  }
}
