import 'package:dota2meta/pages/heroes/components/attribute_filter.dart';
import 'package:dota2meta/pages/heroes/components/lane_filter.dart';
import 'package:dota2meta/pages/heroes/components/name_filter.dart';
import 'package:dota2meta/pages/heroes/components/reset_filter_button.dart';
import 'package:flutter/material.dart';

class Filters extends StatelessWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        NameFilter(),
        SizedBox(
          height: 12,
        ),
        AttributeFilter(),
        SizedBox(
          height: 12,
        ),
        LaneFilter(),
        SizedBox(
          height: 12,
        ),
        ResetFilterButton(),
      ],
    );
  }
}
