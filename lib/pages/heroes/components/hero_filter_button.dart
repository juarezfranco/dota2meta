import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class HeroFilterButton extends StatelessWidget {
  const HeroFilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Scaffold.of(context).openEndDrawer();
      },
      icon: LineIcon.filter(
        size: 28,
      ),
    );
  }
}
