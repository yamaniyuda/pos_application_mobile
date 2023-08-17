import 'package:flutter/material.dart';

class PAMBottomIcon extends StatelessWidget {
  final Icon icon;
  final Color backgroundColor;
  final double width;
  final String? label;
  final Function()? onTab;

  const PAMBottomIcon({
    super.key,
    required this.icon,
    required this.backgroundColor,
    this.width = 30,
    this.onTab,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Column(
        children: [
          Container(
            width: width,
            height: width,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(100)
            ),
            child: icon,
          )
        ],
      ),
    );
  }
}
