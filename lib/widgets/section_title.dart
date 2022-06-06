import 'package:flutter/material.dart';

const _iconSize = 30.0;
const _textSize = 22.0;

class SectionTitle extends StatelessWidget {
  final String text;
  final Icon? icon;
  final List<Widget>? actions;

  const SectionTitle(
    this.text, {
    super.key,
    this.icon,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 8, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(
              icon!.icon,
              size: icon!.size ?? _iconSize,
              color:
                  icon!.color ?? Theme.of(context).textTheme.headline1?.color,
              shadows: Theme.of(context).textTheme.headline1?.shadows,
            ),
            const SizedBox(
              width: 4.0,
            ),
          ],
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 6,
              ),
              child: Text(
                text.toUpperCase(),
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      fontSize: _textSize,
                    ),
              ),
            ),
          ),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}
