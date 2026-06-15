import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_theme.dart';
import 'package:zoko_marketplace/screens/auth/auth_welcome_screen.dart';
import 'package:zoko_marketplace/screens/auth/login_screen.dart';
import 'package:zoko_marketplace/screens/auth/signup_screen.dart';
import 'package:zoko_marketplace/screens/home/marketplace_home_page.dart';

class ZokoMarketplaceApp extends StatelessWidget {
  const ZokoMarketplaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zoko Marketplace',
      theme: ZokoTheme.light,
      home: const AuthWelcomeScreen(),
      routes: {
        LoginScreen.routeName: (_) => const LoginScreen(),
        SignupScreen.routeName: (_) => const SignupScreen(),
        MarketplaceHomePage.routeName: (_) => const MarketplaceHomePage(),
      },
    );
  }
}
