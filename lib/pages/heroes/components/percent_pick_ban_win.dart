import 'package:flutter/material.dart';

class PercentPickBanWin extends StatelessWidget {
  final num percent;
  final num total;

  const PercentPickBanWin({
    required this.percent,
    required this.total,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(4.0),
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
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
