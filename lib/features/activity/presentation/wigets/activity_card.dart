import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/activity.dart';
import 'activity_info_row.dart';
import 'activity_visual.dart';
import 'activity_link_button.dart';

class ActivityCard extends StatelessWidget {
  final Activity? activity;
  final bool isLoading;
  // TODO (learning step): pass activity?.link after adding it to the entity/model.
  final String? activityLink;

  const ActivityCard({super.key, required this.activity, this.isLoading = false, this.activityLink});

  @override
  Widget build(BuildContext context) {
    final isPreview = activity == null;
    final category = activity?.type;
    return Opacity(
      opacity: isLoading ? 0.65 : 1,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: AppColors.ink, width: 2),
          boxShadow: const [BoxShadow(color: AppColors.ink, offset: Offset(5, 5))],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 138,
              foregroundDecoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.ink, width: 2)),
              ),
              child: Stack(
                children: [
                  Positioned.fill(child: ActivityVisual(category: category, preview: isPreview)),
                  Positioned(
                    top: 13,
                    left: 13,
                    child: Transform.rotate(
                      angle: -0.045,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          border: Border.all(color: AppColors.ink, width: 1.5),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: const [BoxShadow(color: AppColors.ink, offset: Offset(2, 2))],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                        child: Text(
                          isPreview ? 'PREVIEW • NO ACTIVITY YET' : (category?.toUpperCase() ?? 'SURPRISE ME'),
                          style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(19, 18, 19, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isPreview ? 'Your next little adventure awaits!' : activity!.activity,
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 26, height: 1.08),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isPreview
                        ? 'Tap the button below to get a real activity from the API.'
                        : 'A fresh idea, just for you.',
                    style: const TextStyle(color: AppColors.mutedInk, fontSize: 12, height: 1.5),
                  ),
                  if (!isPreview && (category != null || activity!.participants != null)) ...[
                    const SizedBox(height: 16),
                    const Divider(color: AppColors.ink, thickness: 0.7),
                    const SizedBox(height: 5),
                    ActivityInfoRow(category: category, participants: activity!.participants),
                  ],
                  if (!isPreview) ActivityLinkButton(link: activityLink),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
