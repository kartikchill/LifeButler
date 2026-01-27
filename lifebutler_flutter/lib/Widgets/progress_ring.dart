import 'package:flutter/material.dart';

class ProgressRing extends StatelessWidget {
  final double progress;

  const ProgressRing({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 90,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 8,
          ),
          Text('${(progress * 100).round()}%'),
        ],
      ),
    );
  }
}
