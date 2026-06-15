import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/models/account_type.dart';
import 'package:zoko_marketplace/screens/auth/login_screen.dart';
import 'package:zoko_marketplace/screens/home/marketplace_home_page.dart';
import 'package:zoko_marketplace/widgets/auth/auth_divider.dart';
import 'package:zoko_marketplace/widgets/auth/auth_text_field.dart';
import 'package:zoko_marketplace/widgets/auth/google_auth_button.dart';
import 'package:zoko_marketplace/widgets/shared/responsive_page.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    final accountType =
        ModalRoute.of(context)?.settings.arguments as AccountType? ??
        AccountType.client;
    final isProfessional = accountType == AccountType.professional;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SafeArea(
        child: ResponsivePage(
          maxWidth: 560,
          mobilePadding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: ListView(
            children: [
              Text(
                isProfessional
                    ? 'Create professional profile'
                    : 'Create account',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: ZokoColors.navy,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isProfessional
                    ? 'Start receiving verified requests from clients.'
                    : 'Find skilled professionals for your next project.',
                style: const TextStyle(
                  color: ZokoColors.textGrey,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 28),
              GoogleAuthButton(
                label: 'Create account with Google',
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    MarketplaceHomePage.routeName,
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 22),
              const AuthDivider(label: 'or create with email'),
              const SizedBox(height: 22),
              const AuthTextField(
                label: 'Full name',
                icon: Icons.person_outline_rounded,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 14),
              const AuthTextField(
                label: 'Email address',
                icon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 14),
              AuthTextField(
                label: isProfessional ? 'Main service' : 'Company or project',
                icon: isProfessional
                    ? Icons.design_services_outlined
                    : Icons.business_center_outlined,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 14),
              const AuthTextField(
                label: 'Password',
                icon: Icons.lock_outline_rounded,
                obscureText: true,
              ),
              const SizedBox(height: 22),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    MarketplaceHomePage.routeName,
                    (route) => false,
                  );
                },
                child: const Text('Create account'),
              ),
              const SizedBox(height: 18),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(color: ZokoColors.textGrey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(
                        LoginScreen.routeName,
                        arguments: accountType,
                      );
                    },
                    child: const Text('Log in'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
