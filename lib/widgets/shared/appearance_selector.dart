import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/theme_controller.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/core/theme/zoko_theme.dart';

class AppearanceSelector extends StatelessWidget {
  const AppearanceSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ThemeController.instance,
      builder: (context, _) {
        final selectedMode = ThemeController.instance.themeMode;
        final themeColors = ZokoThemeColors.of(context);

        return Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: ZokoColors.teal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.dark_mode_outlined,
                color: ZokoColors.teal,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Appearance',
                    style: TextStyle(
                      color: themeColors.text,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Choose light, dark, or system mode',
                    style: TextStyle(
                      color: themeColors.mutedText,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            DropdownButton<ThemeMode>(
              value: selectedMode,
              underline: const SizedBox.shrink(),
              onChanged: (mode) {
                if (mode == null) {
                  return;
                }

                ThemeController.instance.setThemeMode(mode);
              },
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
