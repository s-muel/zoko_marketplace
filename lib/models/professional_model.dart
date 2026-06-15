import 'package:zoko_marketplace/models/portfolio_sample_model.dart';

class ProfessionalModel {
  const ProfessionalModel({
    required this.name,
    required this.role,
    required this.rating,
    required this.jobs,
    required this.imageAsset,
    required this.location,
    required this.about,
    required this.skills,
    required this.startingPrice,
    required this.portfolioSamples,
  });

  final String name;
  final String role;
  final String rating;
  final String jobs;
  final String imageAsset;
  final String location;
  final String about;
  final List<String> skills;
  final String startingPrice;
  final List<PortfolioSampleModel> portfolioSamples;
}
