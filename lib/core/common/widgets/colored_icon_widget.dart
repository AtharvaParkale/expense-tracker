import 'package:flutter/material.dart';

class ColoredIconWidget extends StatelessWidget {
  const ColoredIconWidget({
    super.key,
    required this.color,
    required this.iconData,
    this.size,
  });

  final IconData iconData;
  final Color color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      color: color,
      size: size,
    );
  }
}
