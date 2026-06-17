import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/layout/responsive_breakpoints.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/core/theme/zoko_theme.dart';
import 'package:zoko_marketplace/models/portfolio_sample_model.dart';
import 'package:zoko_marketplace/models/professional_model.dart';
import 'package:zoko_marketplace/widgets/marketplace/hire_request_sheet.dart';
import 'package:zoko_marketplace/widgets/shared/responsive_page.dart';

class ProfessionalProfileScreen extends StatelessWidget {
  const ProfessionalProfileScreen({super.key, required this.professional});

  static const routeName = '/professional-profile';
  final ProfessionalModel professional;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ZokoThemeColors.of(context).text,
        title: const Text('Professional profile'),
      ),
      body: SafeArea(
        child: ResponsivePage(
          maxWidth: 1180,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = ResponsiveBreakpoints.isDesktop(
                constraints.maxWidth,
              );

              final profileContent = Column(
                children: [
                  _ProfileHeader(professional: professional),
                  const SizedBox(height: 18),
                  _InfoPanel(professional: professional),
                  const SizedBox(height: 18),
                  _ServicesPanel(professional: professional),
                  const SizedBox(height: 18),
                  _PortfolioPanel(
                    professional: professional,
                    useGrid: isDesktop,
                  ),
                ],
              );

              final hirePanel = _HireSummaryPanel(
                professional: professional,
                onHire: () => _openHireRequest(context),
              );

              return ListView(
                children: [
                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 7, child: profileContent),
                        const SizedBox(width: 24),
                        SizedBox(width: 340, child: hirePanel),
                      ],
                    )
                  else ...[
                    profileContent,
                    const SizedBox(height: 24),
                    hirePanel,
                  ],
                ],
              );
            },
          ),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  void _openHireRequest(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => HireRequestSheet(professional: professional),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.professional});

  final ProfessionalModel professional;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ZokoColors.navy,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 86,
                height: 86,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.18),
                      blurRadius: 18,
                      offset: const Offset(0, 9),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    professional.imageAsset,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      professional.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      professional.role,
                      style: const TextStyle(
                        color: Color(0xFFC9D5DD),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _HeaderChip(
                icon: Icons.star_rounded,
                label: '${professional.rating} rating',
              ),
              _HeaderChip(icon: Icons.work_rounded, label: professional.jobs),
              _HeaderChip(
                icon: Icons.location_on_rounded,
                label: professional.location,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderChip extends StatelessWidget {
  const _HeaderChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: ZokoColors.green, size: 17),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoPanel extends StatelessWidget {
  const _InfoPanel({required this.professional});

  final ProfessionalModel professional;

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _panelDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: TextStyle(
              color: themeColors.text,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            professional.about,
            style: TextStyle(color: themeColors.mutedText, height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _ServicesPanel extends StatelessWidget {
  const _ServicesPanel({required this.professional});

  final ProfessionalModel professional;

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _panelDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Services',
                style: TextStyle(
                  color: themeColors.text,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Spacer(),
              Text(
                professional.startingPrice,
                style: const TextStyle(
                  color: ZokoColors.green,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final skill in professional.skills)
                Chip(
                  label: Text(skill),
                  backgroundColor: ZokoColors.teal.withValues(alpha: 0.1),
                  side: BorderSide.none,
                  labelStyle: TextStyle(
                    color: themeColors.text,
                    fontWeight: FontWeight.w800,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PortfolioPanel extends StatelessWidget {
  const _PortfolioPanel({required this.professional, required this.useGrid});

  final ProfessionalModel professional;
  final bool useGrid;

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _panelDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Work samples',
            style: TextStyle(
              color: themeColors.text,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          if (useGrid)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: professional.portfolioSamples.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.28,
              ),
              itemBuilder: (context, index) {
                return _PortfolioCard(
                  sample: professional.portfolioSamples[index],
                );
              },
            )
          else
            SizedBox(
              height: 168,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: professional.portfolioSamples.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 220,
                    child: _PortfolioCard(
                      sample: professional.portfolioSamples[index],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _PortfolioCard extends StatelessWidget {
  const _PortfolioCard({required this.sample});

  final PortfolioSampleModel sample;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: sample.color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: sample.color.withValues(alpha: 0.28),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -24,
            top: -18,
            child: Icon(
              sample.icon,
              color: Colors.white.withValues(alpha: 0.16),
              size: 104,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.18),
                  ),
                ),
                child: Icon(sample.icon, color: Colors.white),
              ),
              const Spacer(),
              Text(
                sample.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.2,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                sample.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFFEAF6F7),
                  fontSize: 12,
                  height: 1.3,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HireSummaryPanel extends StatelessWidget {
  const _HireSummaryPanel({required this.professional, required this.onHire});

  final ProfessionalModel professional;
  final VoidCallback onHire;

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _panelDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hire managed by Zoko',
            style: TextStyle(
              color: themeColors.text,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Send a request and Zoko admin will confirm charges with the professional, then invoice you.',
            style: TextStyle(color: themeColors.mutedText, height: 1.4),
          ),
          const SizedBox(height: 16),
          _HireStep(
            icon: Icons.notifications_active_rounded,
            label: 'Admin receives your request',
          ),
          const SizedBox(height: 10),
          _HireStep(
            icon: Icons.handshake_rounded,
            label: 'Professional confirms price',
          ),
          const SizedBox(height: 10),
          _HireStep(
            icon: Icons.receipt_long_rounded,
            label: 'You receive final invoice',
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ZokoColors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.payments_rounded, color: ZokoColors.green),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    professional.startingPrice,
                    style: TextStyle(
                      color: themeColors.text,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: onHire,
            icon: const Icon(Icons.handshake_rounded),
            label: const Text('Hire through Zoko'),
          ),
        ],
      ),
    );
  }
}

class _HireStep extends StatelessWidget {
  const _HireStep({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: ZokoColors.teal.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: ZokoColors.teal, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: themeColors.text,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

BoxDecoration _panelDecoration(BuildContext context) {
  final themeColors = ZokoThemeColors.of(context);

  return BoxDecoration(
    color: themeColors.card,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: themeColors.border),
    boxShadow: [
      BoxShadow(
        color: themeColors.shadow,
        blurRadius: 14,
        offset: const Offset(0, 7),
      ),
    ],
  );
}
