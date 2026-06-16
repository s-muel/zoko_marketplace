import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/constants/app_assets.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/models/category_model.dart';
import 'package:zoko_marketplace/models/job_post_model.dart';
import 'package:zoko_marketplace/models/portfolio_sample_model.dart';
import 'package:zoko_marketplace/models/professional_proposal_model.dart';
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

  List<JobPostModel> getHotJobs() {
    return const [
      JobPostModel(
        title: 'Logo and brand kit for a new fashion shop',
        clientName: 'Ama Stores',
        category: 'Design',
        budget: 'GHS 450',
        deadline: '7 days',
        description:
            'Need a clean logo, color palette, and social media brand direction.',
        postedAt: 'Posted today',
        icon: Icons.palette_rounded,
        color: ZokoColors.teal,
      ),
      JobPostModel(
        title: 'Small business website with WhatsApp contact',
        clientName: 'Bright Foods',
        category: 'Tech',
        budget: 'GHS 1,200',
        deadline: '2 weeks',
        description:
            'Build a responsive website with product sections and contact form.',
        postedAt: 'Posted 1 day ago',
        icon: Icons.web_rounded,
        color: ZokoColors.cyan,
      ),
      JobPostModel(
        title: 'Business plan and investor pitch deck',
        clientName: 'Kofi Mensah',
        category: 'Business',
        budget: 'GHS 800',
        deadline: '10 days',
        description:
            'Prepare a practical business plan and presentation for funding.',
        postedAt: 'Posted 2 days ago',
        icon: Icons.assignment_rounded,
        color: ZokoColors.green,
      ),
      JobPostModel(
        title: 'Product photos and flyer design for online sales',
        clientName: 'Nana Beauty',
        category: 'Design',
        budget: 'GHS 600',
        deadline: '5 days',
        description:
            'Need product images cleaned up and promotional flyers for social media.',
        postedAt: 'Posted 3 days ago',
        icon: Icons.photo_camera_rounded,
        color: ZokoColors.teal,
      ),
      JobPostModel(
        title: 'Home electrical repair and safety check',
        clientName: 'Mr. Owusu',
        category: 'Home',
        budget: 'GHS 350',
        deadline: 'This week',
        description:
            'Looking for a reliable technician to inspect and repair wiring issues.',
        postedAt: 'Posted 4 days ago',
        icon: Icons.electrical_services_rounded,
        color: ZokoColors.cyan,
      ),
    ];
  }

  List<ProfessionalProposalModel> getProfessionalProposals() {
    return const [
      ProfessionalProposalModel(
        jobTitle: 'Small business website with WhatsApp contact',
        clientName: 'Bright Foods',
        budget: 'GHS 1,200',
        submittedAt: 'Sent today',
        message:
            'I can build the website with a responsive layout and WhatsApp contact flow.',
        status: ProposalStatus.underReview,
        icon: Icons.web_rounded,
        color: ZokoColors.cyan,
      ),
      ProfessionalProposalModel(
        jobTitle: 'Logo and brand kit for a new fashion shop',
        clientName: 'Ama Stores',
        budget: 'GHS 450',
        submittedAt: 'Sent 1 day ago',
        message:
            'I can prepare logo concepts, colors, and social media templates.',
        status: ProposalStatus.sentToAdmin,
        icon: Icons.palette_rounded,
        color: ZokoColors.teal,
      ),
      ProfessionalProposalModel(
        jobTitle: 'Business plan and investor pitch deck',
        clientName: 'Kofi Mensah',
        budget: 'GHS 800',
        submittedAt: 'Sent 2 days ago',
        message:
            'I can support the plan structure and prepare investor-ready slides.',
        status: ProposalStatus.quoteRequested,
        icon: Icons.assignment_rounded,
        color: ZokoColors.green,
      ),
      ProfessionalProposalModel(
        jobTitle: 'Product photos and flyer design for online sales',
        clientName: 'Nana Beauty',
        budget: 'GHS 600',
        submittedAt: 'Sent 4 days ago',
        message:
            'I can clean up product photos and deliver polished promotional flyers.',
        status: ProposalStatus.accepted,
        icon: Icons.photo_camera_rounded,
        color: ZokoColors.teal,
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
