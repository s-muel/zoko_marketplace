import 'package:flutter/material.dart';
import 'package:zoko_marketplace/core/constants/app_assets.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/widgets/shared/icon_bubble.dart';

class ZokoHeader extends StatelessWidget {
  const ZokoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            AppAssets.zokoLogo,
            width: 128,
            height: 54,
            fit: BoxFit.contain,
          ),
        ),
        const Spacer(),
        const IconBubble(icon: Icons.notifications_none_rounded),
        const SizedBox(width: 10),
        const CircleAvatar(
          radius: 22,
          backgroundColor: ZokoColors.navy,
          child: Text(
            'AK',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}
