import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/layout/responsive_breakpoints.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/models/category_model.dart';
import 'package:zoko_marketplace/models/professional_model.dart';
import 'package:zoko_marketplace/screens/marketplace/professional_profile_screen.dart';
import 'package:zoko_marketplace/services/marketplace_service.dart';
import 'package:zoko_marketplace/widgets/app/zoko_bottom_nav.dart';
import 'package:zoko_marketplace/widgets/shared/responsive_page.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  static const routeName = '/explore';

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  static const _marketplaceService = MarketplaceService();

  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final categories = _marketplaceService.getCategories();
    final professionals = _filteredProfessionals(
      _marketplaceService.getTopProfessionals(),
    );

    return Scaffold(
      body: SafeArea(
        child: ResponsivePage(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = ResponsiveBreakpoints.isDesktop(
                constraints.maxWidth,
              );

              return ListView(
                children: [
                  _ExploreHeader(isDesktop: isDesktop),
                  const SizedBox(height: 18),
                  const _SearchPanel(),
                  const SizedBox(height: 18),
                  _CategoryFilters(
                    categories: categories,
                    selectedCategory: _selectedCategory,
                    onSelected: (category) {
                      setState(() => _selectedCategory = category);
                    },
                  ),
                  const SizedBox(height: 22),
                  _ResultsHeader(count: professionals.length),
                  const SizedBox(height: 14),
                  if (professionals.isEmpty)
                    const _EmptyResults()
                  else
                    _ProfessionalsGrid(
                      professionals: professionals,
                      isDesktop: isDesktop,
                    ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const ZokoBottomNav(selectedIndex: 1),
      backgroundColor: ZokoColors.canvas,
    );
  }

  List<ProfessionalModel> _filteredProfessionals(
    List<ProfessionalModel> professionals,
  ) {
    if (_selectedCategory == 'All') {
      return professionals;
    }

    return professionals.where((professional) {
      final role = professional.role.toLowerCase();
      final skills = professional.skills.join(' ').toLowerCase();
      final category = _selectedCategory.toLowerCase();

      return role.contains(category) ||
          skills.contains(category) ||
          (category == 'design' && role.contains('ui')) ||
          (category == 'tech' && role.contains('developer')) ||
          (category == 'business' && role.contains('consultant'));
    }).toList();
  }
}

class _EmptyResults extends StatelessWidget {
  const _EmptyResults();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: _cardDecoration(),
      child: const Column(
        children: [
          Icon(Icons.search_off_rounded, color: ZokoColors.teal, size: 42),
          SizedBox(height: 10),
          Text(
            'No professionals yet',
            style: TextStyle(
              color: ZokoColors.navy,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Try another category while more professionals are being added.',
            textAlign: TextAlign.center,
            style: TextStyle(color: ZokoColors.textGrey, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _ExploreHeader extends StatelessWidget {
  const _ExploreHeader({required this.isDesktop});

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 24 : 18),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: ZokoColors.green.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Explore professionals',
                    style: TextStyle(
                      color: ZokoColors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Find the right expert for your next project.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isDesktop ? 34 : 26,
                    height: 1.08,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Browse verified professionals, compare services, and request managed hiring through Zoko.',
                  style: TextStyle(
                    color: Color(0xFFC9D5DD),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          if (isDesktop) ...[
            const SizedBox(width: 24),
            Container(
              width: 118,
              height: 118,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.14),
                ),
              ),
              child: const Icon(
                Icons.manage_search_rounded,
                color: ZokoColors.green,
                size: 54,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SearchPanel extends StatelessWidget {
  const _SearchPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search designers, developers, consultants...',
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: ZokoColors.teal,
              ),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.tune_rounded),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _FilterButton(
                  icon: Icons.location_on_outlined,
                  label: 'Location',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _FilterButton(
                  icon: Icons.star_border_rounded,
                  label: 'Top rated',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: ZokoColors.canvas,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ZokoColors.softGrey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: ZokoColors.navy, size: 19),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: ZokoColors.navy,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryFilters extends StatelessWidget {
  const _CategoryFilters({
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  final List<CategoryModel> categories;
  final String selectedCategory;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final labels = ['All', ...categories.map((category) => category.label)];

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final label = labels[index];
          final isSelected = label == selectedCategory;

          return ChoiceChip(
            selected: isSelected,
            label: Text(label),
            onSelected: (_) => onSelected(label),
            showCheckmark: false,
            selectedColor: ZokoColors.teal,
            backgroundColor: Colors.white,
            side: BorderSide(
              color: isSelected ? ZokoColors.teal : ZokoColors.softGrey,
            ),
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : ZokoColors.navy,
              fontWeight: FontWeight.w900,
            ),
          );
        },
      ),
    );
  }
}

class _ResultsHeader extends StatelessWidget {
  const _ResultsHeader({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Available professionals',
          style: TextStyle(
            color: ZokoColors.navy,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        const Spacer(),
        Text(
          '$count found',
          style: const TextStyle(
            color: ZokoColors.textGrey,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _ProfessionalsGrid extends StatelessWidget {
  const _ProfessionalsGrid({
    required this.professionals,
    required this.isDesktop,
  });

  final List<ProfessionalModel> professionals;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = isDesktop ? 3 : 1;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: professionals.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: isDesktop ? 1.12 : 2.12,
      ),
      itemBuilder: (context, index) {
        return _ProfessionalExploreCard(
          professional: professionals[index],
          isDesktop: isDesktop,
        );
      },
    );
  }
}

class _ProfessionalExploreCard extends StatelessWidget {
  const _ProfessionalExploreCard({
    required this.professional,
    required this.isDesktop,
  });

  final ProfessionalModel professional;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProfessionalProfileScreen.routeName,
          arguments: professional,
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: _cardDecoration(),
        child: isDesktop ? _desktopCard() : _mobileCard(),
      ),
    );
  }

  Widget _desktopCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 108,
          height: 108,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: ZokoColors.softGrey),
            boxShadow: [
              BoxShadow(
                color: ZokoColors.navy.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              professional.imageAsset,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: _ProfessionalCardDetails(professional: professional),
        ),
      ],
    );
  }

  Widget _mobileCard() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            professional.imageAsset,
            width: 86,
            height: 86,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ProfessionalCardDetails(professional: professional),
        ),
        const Icon(Icons.chevron_right_rounded, color: ZokoColors.teal),
      ],
    );
  }
}

class _ProfessionalCardDetails extends StatelessWidget {
  const _ProfessionalCardDetails({required this.professional});

  final ProfessionalModel professional;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                professional.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: ZokoColors.navy,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const Icon(Icons.star_rounded, color: ZokoColors.green, size: 17),
            Text(
              professional.rating,
              style: const TextStyle(
                color: ZokoColors.navy,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          professional.role,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: ZokoColors.textGrey,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final skill in professional.skills.take(2))
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: ZokoColors.teal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  skill,
                  style: const TextStyle(
                    color: ZokoColors.navy,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              professional.startingPrice,
              style: const TextStyle(
                color: ZokoColors.green,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_rounded,
              color: ZokoColors.teal,
              size: 19,
            ),
          ],
        ),
      ],
    );
  }
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
