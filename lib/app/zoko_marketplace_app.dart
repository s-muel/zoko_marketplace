import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_theme.dart';
import 'package:zoko_marketplace/models/hire_request_model.dart';
import 'package:zoko_marketplace/models/job_post_model.dart';
import 'package:zoko_marketplace/models/professional_model.dart';
import 'package:zoko_marketplace/screens/admin/admin_dashboard_screen.dart';
import 'package:zoko_marketplace/screens/auth/auth_welcome_screen.dart';
import 'package:zoko_marketplace/screens/auth/login_screen.dart';
import 'package:zoko_marketplace/screens/auth/signup_screen.dart';
import 'package:zoko_marketplace/screens/home/marketplace_home_page.dart';
import 'package:zoko_marketplace/screens/jobs/all_jobs_screen.dart';
import 'package:zoko_marketplace/screens/jobs/hire_request_details_screen.dart';
import 'package:zoko_marketplace/screens/jobs/hire_requests_screen.dart';
import 'package:zoko_marketplace/screens/jobs/job_details_screen.dart';
import 'package:zoko_marketplace/screens/jobs/post_job_screen.dart';
import 'package:zoko_marketplace/screens/marketplace/explore_screen.dart';
import 'package:zoko_marketplace/screens/marketplace/professional_profile_screen.dart';
import 'package:zoko_marketplace/screens/profile/client_profile_screen.dart';
import 'package:zoko_marketplace/screens/professional/professional_dashboard_screen.dart';
import 'package:zoko_marketplace/screens/professional/professional_jobs_screen.dart';
import 'package:zoko_marketplace/screens/professional/professional_profile_screen.dart'
    as professional_owner;
import 'package:zoko_marketplace/screens/professional/professional_proposals_screen.dart';

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
        AllJobsScreen.routeName: (_) => const AllJobsScreen(),
        HireRequestsScreen.routeName: (_) => const HireRequestsScreen(),
        PostJobScreen.routeName: (_) => const PostJobScreen(),
        ClientProfileScreen.routeName: (_) => const ClientProfileScreen(),
        ProfessionalDashboardScreen.routeName: (_) =>
            const ProfessionalDashboardScreen(),
        ProfessionalJobsScreen.routeName: (_) => const ProfessionalJobsScreen(),
        professional_owner.ProfessionalProfileScreen.routeName: (_) =>
            const professional_owner.ProfessionalProfileScreen(),
        ProfessionalProposalsScreen.routeName: (_) =>
            const ProfessionalProposalsScreen(),
        AdminDashboardScreen.routeName: (_) => const AdminDashboardScreen(),
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

        if (settings.name == JobDetailsScreen.routeName) {
          final job = settings.arguments as JobPostModel;

          return MaterialPageRoute<void>(
            builder: (_) => JobDetailsScreen(job: job),
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
