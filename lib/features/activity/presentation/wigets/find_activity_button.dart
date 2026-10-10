
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class FindActivityButton extends StatelessWidget {
  final bool isLoading;
  final bool retry;
  final VoidCallback onPressed;

  const FindActivityButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    this.retry = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: isLoading
            ? null
            : const [
          BoxShadow(
            color: AppColors.ink,
            offset: Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 58,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: AppColors.primary,
            disabledBackgroundColor: AppColors.mint,
            foregroundColor: AppColors.ink,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                color: AppColors.ink,
                width: 2,
              ),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Decorative doodles behind the content
                const Positioned.fill(
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: ButtonDoodlesPainter(),
                    ),
                  ),
                ),

                // Original button content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Row(
                    children: [
                      if (isLoading)
                        const SizedBox(
                          width: 19,
                          height: 19,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: AppColors.ink,
                          ),
                        )
                      else
                        Icon(
                          retry
                              ? Icons.refresh
                              : Icons.auto_awesome,
                          size: 19,
                        ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: Text(
                          isLoading
                              ? 'Finding an adventure...'
                              : retry
                              ? 'Try Again'
                              : 'Find My Next Adventure',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),

                      const Icon(
                        Icons.arrow_forward,
                        size: 19,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonDoodlesPainter extends CustomPainter {
  const ButtonDoodlesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF145D40).withValues(alpha: 0.24)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Left circle
    canvas.drawCircle(
      Offset(size.width * 0.17, 15),
      5,
      paint,
    );

    // Right circle
    canvas.drawCircle(
      Offset(size.width * 0.84, 39),
      7,
      paint,
    );

    // Small comic sparkles
    void sparkle(double x, double y, double radius) {
      canvas.drawLine(
        Offset(x - radius, y),
        Offset(x + radius, y),
        paint,
      );

      canvas.drawLine(
        Offset(x, y - radius),
        Offset(x, y + radius),
        paint,
      );
    }

    sparkle(size.width * 0.10, 43, 6);
    sparkle(size.width * 0.91, 13, 5);

    // Left curved doodle
    final curve1 = Path()
      ..moveTo(size.width * 0.26, 0)
      ..quadraticBezierTo(
        size.width * 0.32,
        22,
        size.width * 0.25,
        48,
      );

    canvas.drawPath(curve1, paint);

    // Right curved doodle
    final curve2 = Path()
      ..moveTo(size.width * 0.72, 0)
      ..quadraticBezierTo(
        size.width * 0.68,
        24,
        size.width * 0.76,
        55,
      );

    canvas.drawPath(curve2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
