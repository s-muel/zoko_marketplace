import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_theme.dart';
import 'package:zoko_marketplace/models/account_type.dart';
import 'package:zoko_marketplace/screens/auth/signup_screen.dart';
import 'package:zoko_marketplace/screens/home/marketplace_home_page.dart';
import 'package:zoko_marketplace/screens/professional/professional_dashboard_screen.dart';
import 'package:zoko_marketplace/widgets/auth/auth_divider.dart';
import 'package:zoko_marketplace/widgets/auth/auth_text_field.dart';
import 'package:zoko_marketplace/widgets/auth/google_auth_button.dart';
import 'package:zoko_marketplace/widgets/shared/responsive_page.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final accountType =
        ModalRoute.of(context)?.settings.arguments as AccountType? ??
        AccountType.client;
    final themeColors = ZokoThemeColors.of(context);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SafeArea(
        child: ResponsivePage(
          maxWidth: 520,
          mobilePadding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: ListView(
            children: [
              Text(
                'Welcome back',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: themeColors.text,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                accountType == AccountType.client
                    ? 'Log in to manage jobs and hire professionals.'
                    : 'Log in to manage requests and grow your profile.',
                style: TextStyle(
                  color: themeColors.mutedText,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 28),
              GoogleAuthButton(
                label: 'Sign in with Google',
                onPressed: () {
                  _openAccountHome(context, accountType);
                },
              ),
              const SizedBox(height: 22),
              const AuthDivider(label: 'or sign in with email'),
              const SizedBox(height: 22),
              const AuthTextField(
                label: 'Email address',
                icon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 14),
              const AuthTextField(
                label: 'Password',
                icon: Icons.lock_outline_rounded,
                obscureText: true,
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Forgot password?'),
                ),
              ),
              const SizedBox(height: 18),
              FilledButton(
                onPressed: () {
                  _openAccountHome(context, accountType);
                },
                child: const Text('Log in'),
              ),
              const SizedBox(height: 18),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'New to Zoko?',
                    style: TextStyle(color: themeColors.mutedText),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(
                        SignupScreen.routeName,
                        arguments: accountType,
                      );
                    },
                    child: const Text('Create account'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openAccountHome(BuildContext context, AccountType accountType) {
    final routeName = accountType == AccountType.professional
        ? ProfessionalDashboardScreen.routeName
        : MarketplaceHomePage.routeName;

    Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
    );
  }
}
