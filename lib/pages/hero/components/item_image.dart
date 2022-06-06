import 'package:dota2meta/models/item.dart';
import 'package:dota2meta/widgets/image_with_shadow.dart';
import 'package:flutter/material.dart';
import 'package:tasty_toast/tasty_toast.dart';

class ItemImage extends StatelessWidget {
  final Item item;

  const ItemImage(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showToast(context, "${item.name} 💰 ${item.cost}"),
      child: ImageWithShadow(url: item.urlImg),
    );
  }
}
