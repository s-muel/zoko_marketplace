import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/layout/responsive_breakpoints.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/core/theme/zoko_theme.dart';
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
      extendBody: true,
      body: SafeArea(
        child: ResponsivePage(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = ResponsiveBreakpoints.isDesktop(
                constraints.maxWidth,
              );

              return ListView(
                children: [
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
    final themeColors = ZokoThemeColors.of(context);

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: _cardDecoration(context),
      child: Column(
        children: [
          const Icon(
            Icons.search_off_rounded,
            color: ZokoColors.teal,
            size: 42,
          ),
          const SizedBox(height: 10),
          Text(
            'No professionals yet',
            style: TextStyle(
              color: themeColors.text,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try another category while more professionals are being added.',
            textAlign: TextAlign.center,
            style: TextStyle(color: themeColors.mutedText, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _SearchPanel extends StatelessWidget {
  const _SearchPanel();

  @override
  Widget build(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(context),
      child: Column(
        children: [
          TextField(
            style: TextStyle(color: themeColors.text),
            decoration: InputDecoration(
              filled: true,
              fillColor: themeColors.canvas,
              hintText: 'Search designers, developers, consultants...',
              hintStyle: TextStyle(color: themeColors.mutedText),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: ZokoColors.teal,
              ),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.tune_rounded, color: themeColors.text),
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
    final themeColors = ZokoThemeColors.of(context);

    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: themeColors.canvas,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: themeColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: themeColors.text, size: 19),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: themeColors.text,
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
    final themeColors = ZokoThemeColors.of(context);

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
            backgroundColor: themeColors.card,
            side: BorderSide(
              color: isSelected ? ZokoColors.teal : themeColors.border,
            ),
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : themeColors.text,
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
    final themeColors = ZokoThemeColors.of(context);

    return Row(
      children: [
        Text(
          'Available professionals',
          style: TextStyle(
            color: themeColors.text,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        const Spacer(),
        Text(
          '$count found',
          style: TextStyle(
            color: themeColors.mutedText,
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
        childAspectRatio: isDesktop ? 1.48 : 2.12,
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
        decoration: _cardDecoration(context),
        child: isDesktop ? _desktopCard(context) : _mobileCard(),
      ),
    );
  }

  Widget _desktopCard(BuildContext context) {
    final themeColors = ZokoThemeColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 76,
          height: 76,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: themeColors.card,
            shape: BoxShape.circle,
            border: Border.all(color: themeColors.border),
            boxShadow: [
              BoxShadow(
                color: themeColors.shadow,
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
        const SizedBox(height: 10),
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
    final themeColors = ZokoThemeColors.of(context);

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
                style: TextStyle(
                  color: themeColors.text,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const Icon(Icons.star_rounded, color: ZokoColors.green, size: 17),
            Text(
              professional.rating,
              style: TextStyle(
                color: themeColors.text,
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
          style: TextStyle(
            color: themeColors.mutedText,
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
                  style: TextStyle(
                    color: themeColors.text,
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

BoxDecoration _cardDecoration(BuildContext context) {
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
