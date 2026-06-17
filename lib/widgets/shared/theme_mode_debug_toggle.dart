import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/theme_controller.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';

class ThemeModeDebugToggle extends StatelessWidget {
  const ThemeModeDebugToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ThemeController.instance,
      builder: (context, _) {
        final themeMode = ThemeController.instance.themeMode;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return SafeArea(
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, right: 8),
              child: Material(
                color: isDark
                    ? const Color(0xFF102235)
                    : Colors.white.withValues(alpha: 0.92),
                elevation: 8,
                shadowColor: Colors.black.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(999),
                child: IconButton(
                  onPressed: _cycleThemeMode,
                  icon: Icon(
                    _iconFor(themeMode),
                    color: ZokoColors.teal,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _cycleThemeMode() {
    final currentMode = ThemeController.instance.themeMode;
    final nextMode = switch (currentMode) {
      ThemeMode.system => ThemeMode.light,
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
    };

    ThemeController.instance.setThemeMode(nextMode);
  }

  IconData _iconFor(ThemeMode themeMode) {
    return switch (themeMode) {
      ThemeMode.system => Icons.brightness_auto_rounded,
      ThemeMode.light => Icons.light_mode_rounded,
      ThemeMode.dark => Icons.dark_mode_rounded,
    };
  }
}
