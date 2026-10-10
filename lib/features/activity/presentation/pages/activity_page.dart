import 'package:flutter/material.dart';
import 'package:uncle_grandpa/features/activity/presentation/wigets/activity_card.dart';
import 'package:uncle_grandpa/features/activity/presentation/wigets/activity_error_view.dart';
import 'package:uncle_grandpa/features/activity/presentation/wigets/momo_character.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/activity_controller.dart';
import '../wigets/find_activity_button.dart';

class ActivityPage extends StatelessWidget {
  final ActivityController controller;
  const ActivityPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: controller,
          builder: (context, _) {
            final loading = controller.isLoading;
            final failed = controller.error != null;
            final hasActivity = controller.activity != null;
            final heading = loading
                ? 'One weird idea, coming up!'
                : failed
                ? 'Well, that was a plot twist.'
                : hasActivity
                ? "Now that's an adventure!"
                : 'Bored? Not on my watch!';
            return Stack(
              children: [
                const Positioned.fill(child: IgnorePointer(child: CustomPaint(painter: _DotsPainter()))),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 510),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _Header(),
                          const SizedBox(height: 25),
                          const Center(child: Text('✦  A LITTLE WEIRD. A LOT OF FUN.  ✦', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.6))),
                          const SizedBox(height: 13),
                          SizedBox(
                            height: 212,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 11,
                                  child: Transform.rotate(
                                    angle: -0.035,
                                    child: Container(
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        color: AppColors.card,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: AppColors.ink, width: 2),
                                        boxShadow: const [BoxShadow(color: AppColors.ink, offset: Offset(3, 3))],
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(loading ? "MOMO'S THINKING..." : failed ? 'UH-OH!' : 'YOUR PAL, MOMO', style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.mutedInk)),
                                          const SizedBox(height: 8),
                                          Text(heading, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900, height: 1.06)),
                                          const SizedBox(height: 9),
                                          Text(loading ? 'Let me find something good...' : failed ? 'Even a good pal gets a little stuck.' : "Let's make today a little less ordinary.", style: const TextStyle(fontSize: 10, color: AppColors.mutedInk, height: 1.4)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Transform.rotate(
                                        angle: 0.15,
                                        child: Container(
                                          width: 149,
                                          height: 156,
                                          decoration: BoxDecoration(
                                            color: AppColors.sky,
                                            border: Border.all(color: AppColors.ink, width: 2),
                                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(72), topRight: Radius.circular(80), bottomLeft: Radius.circular(85), bottomRight: Radius.circular(62)),
                                          ),
                                        ),
                                      ),
                                      MomoCharacter(isLoading: loading, hasError: failed, hasActivity: hasActivity),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('YOUR NEXT SIDE QUEST', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                              Text('↘', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (failed)
                            ActivityErrorView(message: controller.error!)
                          else
                            ActivityCard(
                              activity: controller.activity,
                              isLoading: loading,
                              activityLink: controller.activity?.link,
                            ),
                          const SizedBox(height: 21),
                          FindActivityButton(isLoading: loading, retry: failed, onPressed: controller.findActivity),
                          const SizedBox(height: 23),
                          const Center(
                            child: Text('✳  LESS SCROLLING. MORE SHENANIGANS.  ✳', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900)),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.ink, width: 2))),
      child: Row(
        children: [
          const Flexible(child: FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Text('Uncle Grandpa', maxLines: 1, style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900, letterSpacing: -1)))),
          const Text('!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppColors.red)),
          const SizedBox(width: 9),
          Container(height: 33, width: 2, color: AppColors.ink),
          const SizedBox(width: 9),
          const Text('THE BOREDOM\nBREAKER', style: TextStyle(fontSize: 8, height: 1.35, fontWeight: FontWeight.w900)),
          const Spacer(),
          const Tooltip(message: 'Uncle Grandpa', child: Icon(Icons.auto_awesome_outlined, size: 25)),
        ],
      ),
    );
  }
}


class _DotsPainter extends CustomPainter {
  const _DotsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.ink.withValues(alpha: 0.18);

    for (double x = 7; x < size.width; x += 15) {
      for (double y = 7; y < size.height; y += 15) {
        canvas.drawCircle(Offset(x, y), 1.0, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

