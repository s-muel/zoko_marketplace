import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/models/professional_model.dart';
import 'package:zoko_marketplace/widgets/marketplace/hire_request_sheet.dart';
import 'package:zoko_marketplace/widgets/shared/responsive_page.dart';

class ProfessionalProfileScreen extends StatelessWidget {
  const ProfessionalProfileScreen({super.key, required this.professional});

  final ProfessionalModel professional;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Professional profile'),
      ),
      body: SafeArea(
        child: ResponsivePage(
          maxWidth: 920,
          child: ListView(
            children: [
              _ProfileHeader(professional: professional),
              const SizedBox(height: 18),
              _InfoPanel(professional: professional),
              const SizedBox(height: 18),
              _ServicesPanel(professional: professional),
              const SizedBox(height: 18),
              _PortfolioPanel(professional: professional),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => _openHireRequest(context),
                icon: const Icon(Icons.handshake_rounded),
                label: const Text('Hire through Zoko'),
              ),
            ],
          ),
        ),
      ),
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
                  child: Image.asset(professional.imageAsset, fit: BoxFit.cover),
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
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _panelDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About',
            style: TextStyle(
              color: ZokoColors.navy,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            professional.about,
            style: const TextStyle(
              color: ZokoColors.textGrey,
              height: 1.45,
            ),
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
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _panelDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Services',
                style: TextStyle(
                  color: ZokoColors.navy,
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
                  labelStyle: const TextStyle(
                    color: ZokoColors.navy,
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
  const _PortfolioPanel({required this.professional});

  final ProfessionalModel professional;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _panelDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Work samples',
            style: TextStyle(
              color: ZokoColors.navy,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 168,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: professional.portfolioSamples.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final sample = professional.portfolioSamples[index];

                return Container(
                  width: 220,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration _panelDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: ZokoColors.softGrey),
    boxShadow: [
      BoxShadow(
        color: ZokoColors.navy.withValues(alpha: 0.08),
        blurRadius: 14,
        offset: const Offset(0, 7),
      ),
    ],
  );
}
