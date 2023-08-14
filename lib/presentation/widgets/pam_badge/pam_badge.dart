import 'package:flutter/material.dart';

class PamBadge extends StatelessWidget {
  final Text text;
  final Color color;

  const PamBadge({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10)
      ),
      child: text,
    );
  }
}
