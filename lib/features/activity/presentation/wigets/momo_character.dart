
import 'dart:math' as math;
import 'package:flutter/material.dart';

enum _MomoReaction { none, success, error }

class MomoCharacter extends StatefulWidget {
  final bool isLoading;
  final bool hasError;
  final bool hasActivity;

  const MomoCharacter({
    super.key,
    required this.isLoading,
    required this.hasError,
    required this.hasActivity,
  });

  @override
  State<MomoCharacter> createState() => _MomoCharacterState();
}

class _MomoCharacterState extends State<MomoCharacter>
    with TickerProviderStateMixin {
  late final AnimationController _floatController;
  late final AnimationController _reactionController;

  _MomoReaction _reaction = _MomoReaction.none;

  @override
  void initState() {
    super.initState();

    // Continuous gentle floating animation.
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    // Plays once for success or error.
    _reactionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  @override
  void didUpdateWidget(covariant MomoCharacter oldWidget) {
    super.didUpdateWidget(oldWidget);

    // A request just finished.
    if (oldWidget.isLoading && !widget.isLoading) {
      if (widget.hasError) {
        _reaction = _MomoReaction.error;
        _reactionController.forward(from: 0);
      } else if (widget.hasActivity) {
        _reaction = _MomoReaction.success;
        _reactionController.forward(from: 0);
      }
    }

    // Stop an old reaction when a new request begins.
    if (!oldWidget.isLoading && widget.isLoading) {
      _reaction = _MomoReaction.none;
      _reactionController.reset();
    }
  }

  String get _pose {
    if (widget.isLoading) return 'thinking';
    if (widget.hasError) return 'oops';
    if (widget.hasActivity) return 'discovery';
    return 'idle';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _floatController,
        _reactionController,
      ]),
      builder: (context, child) {
        final floatValue = _floatController.value;
        final progress = _reactionController.value;

        double offsetY = 0;
        double offsetX = 0;
        double rotation = 0;
        double scale = 1;

        if (widget.isLoading) {
          // Thinking: wobble while waiting.
          rotation = math.sin(floatValue * math.pi * 2) * 0.055;
          offsetY = math.sin(floatValue * math.pi * 2) * 4;
        } else {
          // Idle: gentle up-and-down breathing.
          offsetY = -5 * floatValue;
          scale = 1 + (0.015 * floatValue);

          if (_reactionController.isAnimating) {
            if (_reaction == _MomoReaction.success) {
              // A happy bounce.
              offsetY -= 19 * math.sin(progress * math.pi);
              scale += 0.075 * math.sin(progress * math.pi);
              rotation = 0.07 * math.sin(progress * math.pi * 2);
            }

            if (_reaction == _MomoReaction.error) {
              // A short shake that gradually stops.
              offsetX = 9 *
                  (1 - progress) *
                  math.sin(progress * math.pi * 8);
              rotation = 0.035 *
                  (1 - progress) *
                  math.sin(progress * math.pi * 8);
            }
          }
        }

        return Transform.translate(
          offset: Offset(offsetX, offsetY),
          child: Transform.rotate(
            angle: rotation,
            child: Transform.scale(
              scale: scale,
              child: child,
            ),
          ),
        );
      },

      // The character picture changes smoothly.
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 260),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: Image.asset(
          'assets/momo/momo_$_pose.png',
          key: ValueKey(_pose),
          width: 185,
          height: 180,
          fit: BoxFit.contain,
          semanticLabel: 'Momo cartoon character',
        ),
      ),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    _reactionController.dispose();
    super.dispose();
  }
}
