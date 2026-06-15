import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_theme.dart';
import 'package:zoko_marketplace/models/hire_request_model.dart';
import 'package:zoko_marketplace/models/professional_model.dart';
import 'package:zoko_marketplace/screens/auth/auth_welcome_screen.dart';
import 'package:zoko_marketplace/screens/auth/login_screen.dart';
import 'package:zoko_marketplace/screens/auth/signup_screen.dart';
import 'package:zoko_marketplace/screens/home/marketplace_home_page.dart';
import 'package:zoko_marketplace/screens/jobs/hire_request_details_screen.dart';
import 'package:zoko_marketplace/screens/jobs/hire_requests_screen.dart';
import 'package:zoko_marketplace/screens/marketplace/explore_screen.dart';
import 'package:zoko_marketplace/screens/marketplace/professional_profile_screen.dart';
import 'package:zoko_marketplace/screens/profile/client_profile_screen.dart';

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
        ExploreScreen.routeName: (_) => const ExploreScreen(),
        HireRequestsScreen.routeName: (_) => const HireRequestsScreen(),
        ClientProfileScreen.routeName: (_) => const ClientProfileScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == ProfessionalProfileRoute.name) {
          final professional = settings.arguments as ProfessionalModel;

          return MaterialPageRoute<void>(
            builder: (_) => ProfessionalProfileScreen(
              professional: professional,
            ),
          );
        }

        if (settings.name == HireRequestDetailsScreen.routeName) {
          final request = settings.arguments as HireRequestModel;

          return MaterialPageRoute<void>(
            builder: (_) => HireRequestDetailsScreen(request: request),
          );
        }

        return null;
      },
    );
  }
}

class ProfessionalProfileRoute {
  const ProfessionalProfileRoute._();

  static const name = ProfessionalProfileScreen.routeName;
}
