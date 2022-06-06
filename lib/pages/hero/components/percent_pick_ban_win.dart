import 'package:flutter/material.dart';

class PercentPickBanWin extends StatelessWidget {
  final num percent;
  final num total;

  const PercentPickBanWin({
    required this.percent,
    required this.total,
    super.key,
  }) : assert(percent <= 100);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "${percent.toStringAsFixed(1)}%",
              // style: TextStyle(
              //   color: Colors.blueAccent,
              // ),
            ),
            Text(
              "$total",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
