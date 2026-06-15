import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';

class CalloutPanel extends StatelessWidget {
  const CalloutPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ZokoColors.softGrey),
        boxShadow: [
          BoxShadow(
            color: ZokoColors.navy.withValues(alpha: 0.08),
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
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Earn with Zoko',
                  style: TextStyle(
                    color: ZokoColors.navy,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Create a professional profile and receive verified client requests.',
                  style: TextStyle(color: ZokoColors.textGrey, height: 1.35),
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
