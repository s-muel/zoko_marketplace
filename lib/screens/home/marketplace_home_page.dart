import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/layout/responsive_breakpoints.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/services/marketplace_service.dart';
import 'package:zoko_marketplace/widgets/app/zoko_bottom_nav.dart';
import 'package:zoko_marketplace/widgets/home/callout_panel.dart';
import 'package:zoko_marketplace/widgets/home/category_strip.dart';
import 'package:zoko_marketplace/widgets/home/hero_search.dart';
import 'package:zoko_marketplace/widgets/home/popular_services.dart';
import 'package:zoko_marketplace/widgets/home/professional_list.dart';
import 'package:zoko_marketplace/widgets/home/zoko_header.dart';
import 'package:zoko_marketplace/widgets/shared/responsive_page.dart';
import 'package:zoko_marketplace/widgets/shared/section_title.dart';

class MarketplaceHomePage extends StatelessWidget {
  const MarketplaceHomePage({super.key});

  static const routeName = '/home';
  static const _marketplaceService = MarketplaceService();

  @override
  Widget build(BuildContext context) {
    final categories = _marketplaceService.getCategories();
    final services = _marketplaceService.getPopularServices();
    final professionals = _marketplaceService.getTopProfessionals();

    return Scaffold(
      body: SafeArea(
        child: ResponsivePage(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = ResponsiveBreakpoints.isDesktop(
                constraints.maxWidth,
              );

              final discovery = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeroSearch(),
                  const SizedBox(height: 22),
                  CategoryStrip(categories: categories),
                  const SizedBox(height: 28),
                  const SectionTitle(
                    title: 'Popular services',
                    action: 'See all',
                  ),
                  const SizedBox(height: 14),
                  PopularServices(services: services),
                ],
              );

              final professionalsPanel = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(
                    title: 'Top professionals',
                    action: 'Browse',
                  ),
                  const SizedBox(height: 14),
                  ProfessionalList(professionals: professionals),
                  const SizedBox(height: 28),
                  const CalloutPanel(),
                ],
              );

              return ListView(
                children: [
                  const ZokoHeader(),
                  const SizedBox(height: 24),
                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 7, child: discovery),
                        const SizedBox(width: 28),
                        Expanded(flex: 5, child: professionalsPanel),
                      ],
                    )
                  else ...[
                    discovery,
                    const SizedBox(height: 28),
                    professionalsPanel,
                  ],
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const ZokoBottomNav(selectedIndex: 0),
      backgroundColor: ZokoColors.canvas,
    );
  }
}
