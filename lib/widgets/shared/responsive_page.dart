import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/layout/responsive_breakpoints.dart';

class ResponsivePage extends StatelessWidget {
  const ResponsivePage({
    super.key,
    required this.child,
    this.maxWidth = 1180,
    this.mobilePadding = const EdgeInsets.fromLTRB(20, 14, 20, 24),
    this.desktopPadding = const EdgeInsets.fromLTRB(32, 24, 32, 36),
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsets mobilePadding;
  final EdgeInsets desktopPadding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = ResponsiveBreakpoints.isDesktop(
          constraints.maxWidth,
        );

        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              padding: isDesktop ? desktopPadding : mobilePadding,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
