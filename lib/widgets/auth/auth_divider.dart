import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: ZokoColors.softGrey)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: const TextStyle(
              color: ZokoColors.textGrey,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Expanded(child: Divider(color: ZokoColors.softGrey)),
      ],
    );
  }
}
