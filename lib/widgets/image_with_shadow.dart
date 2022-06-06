import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ImageWithShadow extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;

  const ImageWithShadow({
    required this.url,
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            // offset: const Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, progress) => const SkeletonAvatar(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        width: width,
        height: height,
      ),
    );
  }
}
