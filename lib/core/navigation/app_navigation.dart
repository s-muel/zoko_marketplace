import 'package:flutter/material.dart';

class AppNavigation {
  const AppNavigation._();

  static void openTab(BuildContext context, int index) {
    final routeName = switch (index) {
      0 => '/home',
      1 => '/explore',
      2 => '/hire-requests',
      3 => '/profile',
      _ => null,
    };

    if (routeName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This section is coming soon.')),
      );
      return;
    }

    Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
  }
}
