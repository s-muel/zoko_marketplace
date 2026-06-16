import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    required this.action,
    this.onActionTap,
  });

  final String title;
  final String action;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final actionWidget = Text(
      action,
      style: const TextStyle(
        color: ZokoColors.teal,
        fontWeight: FontWeight.w800,
      ),
    );

    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: ZokoColors.navy,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        const Spacer(),
        if (onActionTap == null)
          actionWidget
        else
          InkWell(
            onTap: onActionTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: actionWidget,
            ),
          ),
      ],
    );
  }
}
