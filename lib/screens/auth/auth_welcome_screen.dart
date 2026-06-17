import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/constants/app_assets.dart';
import 'package:zoko_marketplace/core/layout/responsive_breakpoints.dart';
import 'package:zoko_marketplace/core/theme/zoko_theme.dart';
import 'package:zoko_marketplace/models/account_type.dart';
import 'package:zoko_marketplace/screens/auth/login_screen.dart';
import 'package:zoko_marketplace/screens/auth/signup_screen.dart';
import 'package:zoko_marketplace/widgets/auth/account_type_card.dart';
import 'package:zoko_marketplace/widgets/shared/responsive_page.dart';

class AuthWelcomeScreen extends StatefulWidget {
  const AuthWelcomeScreen({super.key});

  @override
  State<AuthWelcomeScreen> createState() => _AuthWelcomeScreenState();
}

class _AuthWelcomeScreenState extends State<AuthWelcomeScreen> {
  AccountType _selectedAccountType = AccountType.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsivePage(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = ResponsiveBreakpoints.isDesktop(
                constraints.maxWidth,
              );

              final intro = _WelcomeIntro(isDesktop: isDesktop);
              final form = _AccountTypeForm(
                selectedAccountType: _selectedAccountType,
                onChanged: (accountType) {
                  setState(() => _selectedAccountType = accountType);
                },
              );

              return ListView(
                children: [
                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: intro),
                        const SizedBox(width: 56),
                        SizedBox(width: 440, child: form),
                      ],
                    )
                  else ...[
                    intro,
                    const SizedBox(height: 30),
                    form,
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _WelcomeIntro extends StatelessWidget {
  const _WelcomeIntro({required this.isDesktop});

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          AppAssets.zokoLogo,
          width: isDesktop ? 188 : 156,
          height: isDesktop ? 76 : 64,
          fit: BoxFit.contain,
        ),
        SizedBox(height: isDesktop ? 54 : 34),
        Text(
          'Welcome to Zoko Marketplace',
          style: TextStyle(
            color: themeColors.text,
            fontSize: isDesktop ? 46 : 32,
            height: 1.08,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Hire verified professionals or grow your business by offering services clients can trust.',
          style: TextStyle(
            color: themeColors.mutedText,
            fontSize: 16,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

class _AccountTypeForm extends StatelessWidget {
  const _AccountTypeForm({
    required this.selectedAccountType,
    required this.onChanged,
  });

  final AccountType selectedAccountType;
  final ValueChanged<AccountType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AccountTypeCard(
          title: 'I need a professional',
          subtitle: 'Post jobs, compare offers, and hire with confidence.',
          icon: Icons.person_search_rounded,
          isSelected: selectedAccountType == AccountType.client,
          onTap: () => onChanged(AccountType.client),
        ),
        const SizedBox(height: 12),
        AccountTypeCard(
          title: 'I am a professional',
          subtitle: 'Create a profile, list services, and receive jobs.',
          icon: Icons.workspace_premium_rounded,
          isSelected: selectedAccountType == AccountType.professional,
          onTap: () => onChanged(AccountType.professional),
        ),
        const SizedBox(height: 28),
        FilledButton(
          onPressed: () {
            Navigator.of(
              context,
            ).pushNamed(SignupScreen.routeName, arguments: selectedAccountType);
          },
          child: const Text('Create account'),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () {
            Navigator.of(
              context,
            ).pushNamed(LoginScreen.routeName, arguments: selectedAccountType);
          },
          child: const Text('Log in'),
        ),
      ],
    );
  }
}
