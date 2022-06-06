import 'package:dota2meta/pages/heroes/components/attribute_label.dart';
import 'package:dota2meta/pages/heroes/components/percent_pick_ban_win.dart';
import 'package:dota2meta/widgets/image_with_shadow.dart';
import 'package:flutter/material.dart';
import 'package:dota2meta/models/hero.dart' as model_hero;

class HeroItem extends StatelessWidget {
  final model_hero.Hero hero;
  final double _imageWidth = 80;
  final double _imageHeight = 50;
  final double horizontalPadding;
  final double verticalPadding;
  final double statsWidth;
  final VoidCallback? onTap;

  const HeroItem(
    this.hero, {
    required this.statsWidth,
    this.horizontalPadding = 0,
    this.verticalPadding = 8,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: verticalPadding,
                ),
                child: Hero(
                  tag: "img${hero.id}",
                  child: ImageWithShadow(
                    url: hero.urlImg,
                    width: _imageWidth,
                    height: _imageHeight,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hero.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    AttributeLabel(
                      hero.primaryAttribute,
                      textColor: Colors.grey,
                      fontSize: 10,
                      iconSize: 16,
                    ),
                    const SizedBox(height: 2),
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      child: Text(
                        hero.laneRoleDescription.toUpperCase(),
                        style: Theme.of(context).textTheme.caption?.copyWith(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: statsWidth / 3,
                child: PercentPickBanWin(
                  percent: hero.proPickPercent,
                  total: hero.proPick,
                ),
              ),
              SizedBox(
                width: statsWidth / 3,
                child: PercentPickBanWin(
                  percent: hero.proBanPercent,
                  total: hero.proBan,
                ),
              ),
              SizedBox(
                width: statsWidth / 3,
                child: PercentPickBanWin(
                  percent: hero.proWinPercent,
                  total: hero.proWin,
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
