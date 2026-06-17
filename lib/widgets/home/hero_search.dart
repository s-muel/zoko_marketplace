import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/core/theme/zoko_theme.dart';

class HeroSearch extends StatelessWidget {
  const HeroSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeColors = ZokoThemeColors.of(context);
    final searchBackground = isDark
        ? Theme.of(context).scaffoldBackgroundColor
        : Colors.white;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: ZokoColors.navy,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: ZokoColors.green.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'For clients',
                  style: TextStyle(
                    color: ZokoColors.green,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(Icons.verified_rounded, color: ZokoColors.green),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Find trusted professionals for every job.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              height: 1.1,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Post a task, compare offers, and hire skilled service providers across Ghana.',
            style: TextStyle(
              color: Color(0xFFC9D5DD),
              fontSize: 15,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: searchBackground,
              borderRadius: BorderRadius.circular(8),
              border: isDark ? Border.all(color: themeColors.border) : null,
            ),
            child: Row(
              children: [
                const Icon(Icons.search_rounded, color: ZokoColors.teal),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Search logo design, plumbing, legal help...',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: themeColors.mutedText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(Icons.tune_rounded, color: themeColors.text),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
