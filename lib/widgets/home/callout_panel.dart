import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/core/theme/zoko_theme.dart';

class CalloutPanel extends StatelessWidget {
  const CalloutPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: themeColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: themeColors.border),
        boxShadow: [
          BoxShadow(
            color: themeColors.shadow,
            blurRadius: 14,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: ZokoColors.green.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.trending_up_rounded,
              color: ZokoColors.green,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Earn with Zoko',
                  style: TextStyle(
                    color: themeColors.text,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Create a professional profile and receive verified client requests.',
                  style: TextStyle(
                    color: themeColors.mutedText,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_rounded, color: ZokoColors.teal),
        ],
      ),
    );
  }
}
