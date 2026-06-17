import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/models/professional_proposal_model.dart';
import 'package:zoko_marketplace/services/marketplace_service.dart';
import 'package:zoko_marketplace/widgets/app/professional_bottom_nav.dart';
import 'package:zoko_marketplace/widgets/shared/responsive_page.dart';

class ProfessionalProposalsScreen extends StatelessWidget {
  const ProfessionalProposalsScreen({super.key});

  static const routeName = '/professional-proposals';
  static const _marketplaceService = MarketplaceService();

  @override
  Widget build(BuildContext context) {
    final proposals = _marketplaceService.getProfessionalProposals();

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: ResponsivePage(
          maxWidth: 1100,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 760;

              return ListView(
                padding: const EdgeInsets.only(bottom: 92),
                children: [
                  _ProposalsHeader(totalCount: proposals.length),
                  const SizedBox(height: 18),
                  if (isWide)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: proposals.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        mainAxisExtent: 210,
                      ),
                      itemBuilder: (context, index) {
                        return _ProposalCard(proposal: proposals[index]);
                      },
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: proposals.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 210,
                          child: _ProposalCard(proposal: proposals[index]),
                        );
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const ProfessionalBottomNav(selectedIndex: 2),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}

class _ProposalsHeader extends StatelessWidget {
  const _ProposalsHeader({required this.totalCount});

  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ZokoColors.navy,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: ZokoColors.navy.withValues(alpha: 0.14),
            blurRadius: 22,
            offset: const Offset(0, 11),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Proposals',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$totalCount jobs you have shown interest in',
            style: const TextStyle(
              color: Color(0xFFC9D5DD),
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProposalCard extends StatelessWidget {
  const _ProposalCard({required this.proposal});

  final ProfessionalProposalModel proposal;

  @override
  Widget build(BuildContext context) {
    final statusUi = _statusUi(proposal.status);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: proposal.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(proposal.icon, color: proposal.color, size: 22),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      proposal.clientName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: ZokoColors.navy,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      proposal.submittedAt,
                      style: const TextStyle(
                        color: ZokoColors.textGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              _StatusPill(label: statusUi.label, color: statusUi.color),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            proposal.jobTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: ZokoColors.navy,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            proposal.message,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: ZokoColors.textGrey,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  proposal.budget,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: ZokoColors.green,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: ZokoColors.teal,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

({String label, Color color}) _statusUi(ProposalStatus status) {
  return switch (status) {
    ProposalStatus.sentToAdmin => (
        label: 'Sent',
        color: ZokoColors.teal,
      ),
    ProposalStatus.underReview => (
        label: 'Review',
        color: ZokoColors.cyan,
      ),
    ProposalStatus.quoteRequested => (
        label: 'Quote',
        color: const Color(0xFFF5A623),
      ),
    ProposalStatus.accepted => (
        label: 'Accepted',
        color: ZokoColors.green,
      ),
  };
}

BoxDecoration _cardDecoration() {
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
