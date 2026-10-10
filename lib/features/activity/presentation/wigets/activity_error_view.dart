import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ActivityErrorView extends StatelessWidget {
  final String message;
  const ActivityErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: AppColors.yellow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.ink, width: 2),
        boxShadow: const [BoxShadow(color: AppColors.ink, offset: Offset(4, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [Icon(Icons.sentiment_dissatisfied_outlined), SizedBox(width: 8), Text('A LITTLE PLOT TWIST', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 11))]),
          const SizedBox(height: 10),
          const Text("Oops! I couldn't find an idea right now.", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 23, height: 1.1)),
          const SizedBox(height: 9),
          Text(message, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
