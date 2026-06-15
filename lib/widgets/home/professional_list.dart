import 'package:flutter/material.dart';
import 'package:zoko_marketplace/app/zoko_marketplace_app.dart';
import 'package:zoko_marketplace/core/theme/zoko_colors.dart';
import 'package:zoko_marketplace/models/professional_model.dart';

class ProfessionalList extends StatelessWidget {
  const ProfessionalList({super.key, required this.professionals});

  final List<ProfessionalModel> professionals;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final professional in professionals) ...[
          _ProfessionalTile(professional: professional),
          if (professional != professionals.last) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _ProfessionalTile extends StatelessWidget {
  const _ProfessionalTile({required this.professional});

  final ProfessionalModel professional;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProfessionalProfileRoute.name,
          arguments: professional,
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
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
        ),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: ZokoColors.softGrey),
                boxShadow: [
                  BoxShadow(
                    color: ZokoColors.navy.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  professional.imageAsset,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    professional.name,
                    style: const TextStyle(
                      color: ZokoColors.navy,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    professional.role,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: ZokoColors.textGrey),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: ZokoColors.green,
                      size: 18,
                    ),
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
                  professional.jobs,
                  style: const TextStyle(
                    color: ZokoColors.textGrey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right_rounded,
              color: ZokoColors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
