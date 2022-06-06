import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dota2meta/models/hero.dart' as model_hero;

class HeroImage extends StatelessWidget {
  final model_hero.Hero hero;

  const HeroImage(this.hero, {super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: hero.urlImg,
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) => Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(70),
        child: CircleAvatar(
          radius: 70,
          backgroundImage: imageProvider,
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
