import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/constants/app_assets.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/models/category_model.dart';
import 'package:zoko_marketplace/models/portfolio_sample_model.dart';
import 'package:zoko_marketplace/models/professional_model.dart';
import 'package:zoko_marketplace/models/service_model.dart';

class MarketplaceService {
  const MarketplaceService();

  List<CategoryModel> getCategories() {
    return const [
      CategoryModel(
        label: 'Design',
        icon: Icons.brush_rounded,
        color: ZokoColors.teal,
      ),
      CategoryModel(
        label: 'Tech',
        icon: Icons.code_rounded,
        color: ZokoColors.navy,
      ),
      CategoryModel(
        label: 'Home',
        icon: Icons.handyman_rounded,
        color: ZokoColors.green,
      ),
      CategoryModel(
        label: 'Business',
        icon: Icons.work_outline_rounded,
        color: ZokoColors.cyan,
      ),
    ];
  }

  List<ServiceModel> getPopularServices() {
    return const [
      ServiceModel(
        title: 'Brand identity package',
        price: 'From GHS 200',
        icon: Icons.auto_awesome_rounded,
        color: ZokoColors.teal,
      ),
      ServiceModel(
        title: 'Mobile app UI design',
        price: 'From GHS 900',
        icon: Icons.phone_iphone_rounded,
        color: ZokoColors.green,
      ),
      ServiceModel(
        title: 'Business registration',
        price: 'From GHS 650',
        icon: Icons.assignment_turned_in_rounded,
        color: ZokoColors.cyan,
      ),
    ];
  }

  List<ProfessionalModel> getTopProfessionals() {
    return const [
      ProfessionalModel(
        name: 'Alfred A.',
        role: 'Business Consultant',
        rating: '4.9',
        jobs: '127 jobs',
        imageAsset: AppAssets.alfredProfile,
        location: 'Accra, Ghana',
        about:
            'Helps growing businesses structure operations, proposals, and market entry plans.',
        skills: ['Business plans', 'Strategy', 'Pitch decks'],
        startingPrice: 'From GHS 650',
        portfolioSamples: [
          PortfolioSampleModel(
            title: 'Startup pitch deck',
            subtitle: 'Investor-ready deck for a food brand',
            icon: Icons.slideshow_rounded,
            color: ZokoColors.teal,
          ),
          PortfolioSampleModel(
            title: 'Market entry plan',
            subtitle: 'Launch plan for a service company',
            icon: Icons.trending_up_rounded,
            color: ZokoColors.green,
          ),
          PortfolioSampleModel(
            title: 'Operations audit',
            subtitle: 'Workflow and cost review',
            icon: Icons.fact_check_rounded,
            color: ZokoColors.cyan,
          ),
        ],
      ),
      ProfessionalModel(
        name: 'Emmanuel K.',
        role: 'UI/UX Designer',
        rating: '4.8',
        jobs: '89 jobs',
        imageAsset: AppAssets.emmanuelProfile,
        location: 'Kumasi, Ghana',
        about:
            'Designs polished brand, mobile, and web experiences for startups and service businesses.',
        skills: ['Logo design', 'Mobile UI', 'Brand identity'],
        startingPrice: 'From GHS 200',
        portfolioSamples: [
          PortfolioSampleModel(
            title: 'Brand identity kit',
            subtitle: 'Logo, colors, and social templates',
            icon: Icons.palette_rounded,
            color: ZokoColors.teal,
          ),
          PortfolioSampleModel(
            title: 'Mobile app screens',
            subtitle: 'Booking app UI concept',
            icon: Icons.phone_iphone_rounded,
            color: ZokoColors.green,
          ),
          PortfolioSampleModel(
            title: 'Poster campaign',
            subtitle: 'Launch visuals for a local brand',
            icon: Icons.auto_awesome_rounded,
            color: ZokoColors.cyan,
          ),
        ],
      ),
      ProfessionalModel(
        name: 'Samuel O.',
        role: 'Full Stack Developer',
        rating: '5.0',
        jobs: '64 jobs',
        imageAsset: AppAssets.samuelProfile,
        location: 'Tema, Ghana',
        about:
            'Builds responsive websites, dashboards, and full-stack business tools.',
        skills: ['Flutter', 'Web apps', 'APIs'],
        startingPrice: 'From GHS 900',
        portfolioSamples: [
          PortfolioSampleModel(
            title: 'Admin dashboard',
            subtitle: 'Analytics and order management',
            icon: Icons.dashboard_customize_rounded,
            color: ZokoColors.teal,
          ),
          PortfolioSampleModel(
            title: 'Marketplace app',
            subtitle: 'Client and vendor workflow',
            icon: Icons.storefront_rounded,
            color: ZokoColors.green,
          ),
          PortfolioSampleModel(
            title: 'API integration',
            subtitle: 'Payments and notifications',
            icon: Icons.api_rounded,
            color: ZokoColors.cyan,
          ),
        ],
      ),
    ];
  }
}
