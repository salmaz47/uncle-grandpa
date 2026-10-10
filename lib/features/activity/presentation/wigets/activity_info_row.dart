import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ActivityInfoRow extends StatelessWidget {
  final String? category;
  final int? participants;

  const ActivityInfoRow({super.key, this.category, this.participants});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        if (category != null && category!.trim().isNotEmpty)
          _InfoChip(icon: Icons.auto_awesome_outlined, text: category!),
        if (participants != null)
          _InfoChip(
            icon: Icons.people_outline,
            text: participants == 1 ? 'Just you' : '$participants people',
          ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: AppColors.ink),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
