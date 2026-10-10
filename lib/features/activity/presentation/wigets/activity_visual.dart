import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Category-only artwork. No API or state-management dependencies.
class ActivityVisual extends StatelessWidget {
  final String? category;
  final bool preview;
  const ActivityVisual({super.key, required this.category, this.preview = false});

  @override
  Widget build(BuildContext context) {
    final style = _styleFor(category, preview);
    return DecoratedBox(
      decoration: BoxDecoration(color: style.background),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const CustomPaint(painter: _ComicDots()),
          Positioned(top: -28, right: -24, child: Transform.rotate(
            angle: .2,
            child: Container(width: 102, height: 102,
              decoration: BoxDecoration(color: AppColors.card.withValues(alpha: .33),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.ink.withValues(alpha: .18), width: 2)),
            ),
          )),
          Positioned(left: 22, bottom: 7, child: Transform.rotate(
            angle: -.2,
            child: Icon(style.accent, size: 34, color: AppColors.ink.withValues(alpha: .28)),
          )),
          Center(child: Transform.rotate(
            angle: -.10,
            child: Container(
              width: 92, height: 92,
              decoration: BoxDecoration(color: AppColors.card,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.ink, width: 2),
                boxShadow: const [BoxShadow(color: AppColors.ink, offset: Offset(5, 5))]),
              child: Icon(style.icon, size: 54, color: AppColors.ink),
            ),
          )),
          const Positioned(top: 15, right: 18,
            child: Icon(Icons.star_rounded, color: AppColors.ink, size: 21)),
          const Positioned(bottom: 13, right: 42,
            child: Icon(Icons.auto_awesome, color: AppColors.ink, size: 16)),
        ],
      ),
    );
  }
}

class _CategoryStyle {
  final Color background;
  final IconData icon;
  final IconData accent;
  const _CategoryStyle(this.background, this.icon, this.accent);
}

_CategoryStyle _styleFor(String? category, bool preview) {
  if (preview) return const _CategoryStyle(AppColors.pink, Icons.lightbulb_outline, Icons.bolt);
  switch (category?.toLowerCase().trim()) {
    case 'education':
    case 'learning':
      return const _CategoryStyle(AppColors.yellow, Icons.menu_book_rounded, Icons.school_outlined);
    case 'recreational':
    case 'recreation':
      return const _CategoryStyle(AppColors.sky, Icons.explore_rounded, Icons.map_outlined);
    case 'social':
      return const _CategoryStyle(AppColors.pink, Icons.groups_rounded, Icons.favorite_outline);
    case 'diy':
      return const _CategoryStyle(AppColors.mint, Icons.handyman_rounded, Icons.construction);
    case 'charity':
      return const _CategoryStyle(AppColors.pink, Icons.volunteer_activism, Icons.favorite);
    case 'cooking':
      return const _CategoryStyle(AppColors.yellow, Icons.restaurant_rounded, Icons.local_cafe_outlined);
    case 'relaxation':
      return const _CategoryStyle(AppColors.pink, Icons.spa_rounded, Icons.self_improvement);
    case 'music':
      return const _CategoryStyle(AppColors.yellow, Icons.music_note_rounded, Icons.graphic_eq_rounded);
    case 'busywork':
      return const _CategoryStyle(AppColors.blue, Icons.checklist_rounded, Icons.auto_awesome);
    default:
      return const _CategoryStyle(AppColors.mint, Icons.auto_awesome_rounded, Icons.question_mark_rounded);
  }
}

class _ComicDots extends CustomPainter {
  const _ComicDots();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.ink.withValues(alpha: .14);
    for (double x = 6; x < size.width; x += 11) {
      for (double y = 6; y < size.height; y += 11) {
        canvas.drawCircle(Offset(x, y), .65, paint);
      }
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
