import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';

class ZokoTheme {
  const ZokoTheme._();

  static ThemeData get light {
    return _buildTheme(
      brightness: Brightness.light,
      scaffoldBackgroundColor: ZokoColors.canvas,
      surfaceColor: Colors.white,
      textColor: ZokoColors.navy,
      mutedTextColor: ZokoColors.textGrey,
      borderColor: ZokoColors.softGrey,
    );
  }

  static ThemeData get dark {
    return _buildTheme(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF02111D),
      surfaceColor: const Color(0xFF102235),
      textColor: const Color(0xFFF5FBFF),
      mutedTextColor: const Color(0xFF9CB4C4),
      borderColor: const Color(0xFF1C4357),
    );
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color scaffoldBackgroundColor,
    required Color surfaceColor,
    required Color textColor,
    required Color mutedTextColor,
    required Color borderColor,
  }) {
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ZokoColors.teal,
        brightness: brightness,
        primary: isDark ? ZokoColors.teal : ZokoColors.navy,
        secondary: ZokoColors.teal,
        tertiary: ZokoColors.green,
        surface: surfaceColor,
        onSurface: textColor,
        outline: borderColor,
      ),
      fontFamily: 'Roboto',
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBackgroundColor,
        foregroundColor: textColor,
        elevation: 0,
      ),
      dividerTheme: DividerThemeData(color: borderColor),
      textTheme: ThemeData(brightness: brightness).textTheme.apply(
            bodyColor: textColor,
            displayColor: textColor,
          ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(54),
          backgroundColor: ZokoColors.teal,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(54),
          foregroundColor: textColor,
          side: BorderSide(color: borderColor),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        labelStyle: TextStyle(color: mutedTextColor),
        hintStyle: TextStyle(color: mutedTextColor),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ZokoColors.teal, width: 1.6),
        ),
      ),
      extensions: [
        ZokoThemeColors(
          canvas: scaffoldBackgroundColor,
          card: surfaceColor,
          text: textColor,
          mutedText: mutedTextColor,
          border: borderColor,
          shadow: isDark
              ? Colors.black.withValues(alpha: 0.35)
              : ZokoColors.navy.withValues(alpha: 0.08),
        ),
      ],
    );
  }
}

class ZokoThemeColors extends ThemeExtension<ZokoThemeColors> {
  const ZokoThemeColors({
    required this.canvas,
    required this.card,
    required this.text,
    required this.mutedText,
    required this.border,
    required this.shadow,
  });

  final Color canvas;
  final Color card;
  final Color text;
  final Color mutedText;
  final Color border;
  final Color shadow;

  static ZokoThemeColors of(BuildContext context) {
    return Theme.of(context).extension<ZokoThemeColors>()!;
  }

  @override
  ZokoThemeColors copyWith({
    Color? canvas,
    Color? card,
    Color? text,
    Color? mutedText,
    Color? border,
    Color? shadow,
  }) {
    return ZokoThemeColors(
      canvas: canvas ?? this.canvas,
      card: card ?? this.card,
      text: text ?? this.text,
      mutedText: mutedText ?? this.mutedText,
      border: border ?? this.border,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  ZokoThemeColors lerp(ThemeExtension<ZokoThemeColors>? other, double t) {
    if (other is! ZokoThemeColors) {
      return this;
    }

    return ZokoThemeColors(
      canvas: Color.lerp(canvas, other.canvas, t)!,
      card: Color.lerp(card, other.card, t)!,
      text: Color.lerp(text, other.text, t)!,
      mutedText: Color.lerp(mutedText, other.mutedText, t)!,
      border: Color.lerp(border, other.border, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
    );
  }
}
