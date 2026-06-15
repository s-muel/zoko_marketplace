import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/constants/app_assets.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/models/category_model.dart';
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
      ),
      ProfessionalModel(
        name: 'Emmanuel K.',
        role: 'UI/UX Designer',
        rating: '4.8',
        jobs: '89 jobs',
        imageAsset: AppAssets.emmanuelProfile,
      ),
      ProfessionalModel(
        name: 'Samuel O.',
        role: 'Full Stack Developer',
        rating: '5.0',
        jobs: '64 jobs',
        imageAsset: AppAssets.samuelProfile,
      ),
    ];
  }
}
