import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';

class IconBubble extends StatelessWidget {
  const IconBubble({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ZokoColors.softGrey),
      ),
      child: Icon(icon, color: ZokoColors.navy),
    );
  }
}
